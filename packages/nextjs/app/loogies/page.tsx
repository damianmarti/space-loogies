"use client";

import React, { useEffect, useState } from "react";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount } from "wagmi";
import { useWalletClient } from "wagmi";
import { useScaffoldContract } from "~~/hooks/scaffold-eth";
import { notification } from "~~/utils/scaffold-eth";

const Loogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const { data: walletClient } = useWalletClient();

  const [yourLoogies, setYourLoogies] = useState<any[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(true);

  const LoogiesQuery = gql`
    query Tokens($owner: String) {
      tokens(where: { ownerId: $owner, kind_in: ["OptimisticLoogie", "FancyLoogie"] }) {
        items {
          id
          kind
          tokenURI
        }
      }
    }
  `;

  const [{ data: loogiesData }] = useQuery({
    query: LoogiesQuery,
    variables: {
      owner: connectedAddress,
    },
  });

  console.log("loogiesData", loogiesData);

  const { data: loogieContract } = useScaffoldContract({ contractName: "YourCollectible", walletClient });
  const { data: fancyLoogieContract } = useScaffoldContract({ contractName: "FancyLoogie", walletClient });
  const { data: spaceContract } = useScaffoldContract({ contractName: "SpaceLoogie", walletClient });

  useEffect(() => {
    const updateYourLoogies = async () => {
      setIsYourLoogiesLoading(true);
      if (fancyLoogieContract && loogiesData && loogiesData.tokens.items.length > 0) {
        const collectibleUpdate: any[] = [];
        const loogies = loogiesData.tokens.items;
        for (let tokenIndex = 0; tokenIndex < loogies.length; tokenIndex++) {
          try {
            const id = loogies[tokenIndex].id;
            const tokenId = id.split(":")[1];
            const kind = loogies[tokenIndex].kind;
            let tokenURI = loogies[tokenIndex].tokenURI;
            // we need to fetch the tokenURI on FancyLoogies because changing accessories are not tracked by the indexer
            if (kind === "FancyLoogie") {
              tokenURI = await fancyLoogieContract.read.tokenURI([tokenId]);
            }
            const jsonManifestString = atob(tokenURI.substring(29));

            try {
              const jsonManifest = JSON.parse(jsonManifestString);
              collectibleUpdate.push({ id, tokenId, kind, owner: connectedAddress, ...jsonManifest });
            } catch (e) {
              console.log(e);
            }
          } catch (e) {
            console.log(e);
          }
        }
        console.log("collectibleUpdate", collectibleUpdate);
        setYourLoogies(collectibleUpdate.reverse());
      } else {
        setYourLoogies([]);
      }
      setIsYourLoogiesLoading(false);
    };
    updateYourLoogies();
  }, [loogiesData]);

  const handleMint = async (kind: string, loogieId: bigint) => {
    if (!loogieContract || !fancyLoogieContract || !spaceContract) {
      notification.error("Contracts not loaded");
      return;
    }

    if (kind === "OptimisticLoogie") {
      await loogieContract.write.approve([spaceContract.address, loogieId]);
      await spaceContract.write.mintItemWithLoogie([loogieId]);
    } else if (kind === "FancyLoogie") {
      await fancyLoogieContract.write.approve([spaceContract.address, loogieId]);
      await spaceContract.write.mintItemWithFancyLoogie([loogieId]);
    } else {
      notification.error("Invalid Loogie kind");
      return;
    }

    notification.success("Minted SpaceLoogie");
  };

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-4xl font-bold">Your Loogies</span>
          </h1>
          <div className="flex justify-center items-center space-x-2">
            {isYourLoogiesLoading ? (
              <p className="my-2 font-medium">Loading...</p>
            ) : (
              <div>
                <div className="grid grid-cols-3 gap-4">
                  {yourLoogies.map(loogie => {
                    return (
                      <div
                        key={loogie.id}
                        className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl"
                      >
                        <h2 className="text-xl font-bold">{loogie.name}</h2>
                        <img src={loogie.image} alt={loogie.name} className="w-48 h-48" />
                        <button onClick={() => handleMint(loogie.kind, loogie.tokenId)} className="btn btn-primary">
                          Mint SpaceLoogie
                        </button>
                      </div>
                    );
                  })}
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
};

export default Loogies;
