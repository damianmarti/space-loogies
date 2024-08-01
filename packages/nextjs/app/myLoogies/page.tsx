"use client";

import React, { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { createPublicClient, hexToBigInt, http } from "viem";
import { useAccount } from "wagmi";
import { useWalletClient } from "wagmi";
import { OptimisticLoogiesLogoIcon } from "~~/components/assets/OptimisticLoogiesLogoIcon";
import { useScaffoldContract } from "~~/hooks/scaffold-eth";
import scaffoldConfig from "~~/scaffold.config";
import { notification } from "~~/utils/scaffold-eth";

const publicClient = createPublicClient({
  chain: scaffoldConfig.targetNetworks[0],
  transport: http(),
});

const MyLoogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const { data: walletClient } = useWalletClient();

  const [yourLoogies, setYourLoogies] = useState<any[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(false);
  const [isSpaceLoogieModalOpen, setIsSpaceLoogieModalOpen] = useState(false);
  const [mintedSpaceLoogie, setMintedSpaceLoogie] = useState<any>(null);
  const [isMinting, setIsMinting] = useState(false);

  const LoogiesQuery = gql`
    query Tokens($owner: String) {
      tokens(where: { ownerId: $owner, kind_in: ["OptimisticLoogie", "FancyLoogie"] }) {
        items {
          id
          kind
          tokenURI
          spaceshipMinted
        }
      }
    }
  `;

  const [{ data: loogiesData }, reexecuteLoogiesQuery] = useQuery({
    query: LoogiesQuery,
    variables: {
      owner: connectedAddress,
    },
  });

  console.log("loogiesData", loogiesData);
  console.log("isYourLoogiesLoading", isYourLoogiesLoading);

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
            const spaceshipMinted = loogies[tokenIndex].spaceshipMinted;
            let tokenURI = loogies[tokenIndex].tokenURI;
            // we need to fetch the tokenURI on FancyLoogies because changing accessories are not tracked by the indexer
            if (kind === "FancyLoogie") {
              tokenURI = await fancyLoogieContract.read.tokenURI([tokenId]);
            }
            const jsonManifestString = atob(tokenURI.substring(29));

            try {
              const jsonManifest = JSON.parse(jsonManifestString);
              collectibleUpdate.push({ id, tokenId, kind, spaceshipMinted, owner: connectedAddress, ...jsonManifest });
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
        console.log("no loogies found");
        setYourLoogies([]);
      }
      setIsYourLoogiesLoading(false);
    };
    console.log("useEffect");
    updateYourLoogies();
  }, [Boolean(fancyLoogieContract), loogiesData]);

  const sleep = (ms: number) => new Promise(r => setTimeout(r, ms));

  const handleMint = async (kind: string, loogieId: bigint) => {
    if (!loogieContract || !fancyLoogieContract || !spaceContract) {
      notification.error("Contracts not loaded");
      return;
    }

    setIsMinting(true);
    let transactionHash;
    if (kind === "OptimisticLoogie") {
      await loogieContract.write.approve([spaceContract.address, loogieId]);
      transactionHash = await spaceContract.write.mintItemWithLoogie([loogieId]);
    } else if (kind === "FancyLoogie") {
      await fancyLoogieContract.write.approve([spaceContract.address, loogieId]);
      transactionHash = await spaceContract.write.mintItemWithFancyLoogie([loogieId]);
    } else {
      notification.error("Invalid Loogie kind");
      setIsMinting(false);
      return;
    }

    const transaction = await publicClient.getTransactionReceipt({
      hash: transactionHash,
    });
    console.log("transaction", transaction);
    const spaceLoogieIdHex = transaction.logs[0].topics[3];

    if (!spaceLoogieIdHex) {
      notification.success("Minted SpaceLoogie");
      setIsMinting(false);
      return;
    }

    const spaceLoogieId = hexToBigInt(spaceLoogieIdHex);
    const tokenURI = await spaceContract.read.tokenURI([spaceLoogieId]);
    console.log("tokenURI", tokenURI);
    const jsonManifestString = atob(tokenURI.substring(29));
    const jsonManifest = JSON.parse(jsonManifestString);
    setMintedSpaceLoogie({ id: spaceLoogieId, ...jsonManifest });
    setIsSpaceLoogieModalOpen(true);
    setIsMinting(false);
    await sleep(5000);
    reexecuteLoogiesQuery({ requestPolicy: "network-only" });
  };

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <div className="flex justify-center items-center space-x-2">
            {isYourLoogiesLoading ? (
              <p className="my-2 font-medium">Loading...</p>
            ) : (
              <div>
                {yourLoogies.length === 0 ? (
                  <div className="my-2 text-xl bg-secondary border-2 border-black rounded-2xl p-8 text-center">
                    <p className="font-bold">You don&apos;t have any Loogie.</p>
                    <p className="mt-16">
                      You can mint a <span className="font-bold">OptimiticLoogie</span> at the{" "}
                      <span className="font-bold">OptimisticLoogies website</span>.
                    </p>
                    <p className="mt-8">
                      <Link
                        href="https://optimistic.loogies.io"
                        target="_blank"
                        className="btn btn-primary text-xl p-4 sm:px-24 px-12 h-24"
                      >
                        <OptimisticLoogiesLogoIcon />
                      </Link>
                    </p>
                  </div>
                ) : (
                  <div className="grid sm:grid-cols-4 grid-cols-1 gap-16">
                    {yourLoogies.map(loogie => {
                      return (
                        <div
                          key={loogie.id}
                          className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-2xl border-2 border-black"
                        >
                          <h2 className="text-xl font-bold border-2 border-black rounded-2xl p-2 -mb-6 bg-white z-20">
                            {loogie.name}
                          </h2>
                          <Image
                            src={loogie.image}
                            alt={loogie.name}
                            width="300"
                            height="300"
                            className="border-2 border-black rounded-3xl bg-gray-200"
                          />
                          <button
                            onClick={() => handleMint(loogie.kind, loogie.tokenId)}
                            className="btn btn-primary mt-8"
                            disabled={loogie.spaceshipMinted || isMinting}
                          >
                            {isMinting ? (
                              <span className="loading loading-dots loading-md"></span>
                            ) : loogie.spaceshipMinted ? (
                              "Minted"
                            ) : (
                              "Mint SpaceLoogie"
                            )}
                          </button>
                        </div>
                      );
                    })}
                  </div>
                )}
              </div>
            )}
          </div>
        </div>
      </div>
      <dialog id="my_modal_1" className="modal" open={isSpaceLoogieModalOpen}>
        <div className="modal-box">
          <form method="dialog">
            <button className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
          </form>
          <h3 className="font-bold text-xl text-center">{mintedSpaceLoogie?.name} Minted!!</h3>
          <div className="flex flex-col items-center py-4">
            <Image
              src={mintedSpaceLoogie?.image}
              alt={mintedSpaceLoogie?.name}
              width="300"
              height="300"
              className="border-2 border-black rounded-3xl p-6 pt-6 bg-gray-200"
            />
          </div>
        </div>
      </dialog>
    </>
  );
};

export default MyLoogies;
