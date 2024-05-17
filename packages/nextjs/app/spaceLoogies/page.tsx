"use client";

import React, { useEffect, useState } from "react";
import { createSearchParamsBailoutProxy } from "next/dist/client/components/searchparams-bailout-proxy";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { useWalletClient } from "wagmi";
import { useScaffoldContract, useScaffoldContractRead } from "~~/hooks/scaffold-eth";
import { notification } from "~~/utils/scaffold-eth";

const SpaceLoogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();
  const { data: walletClient } = useWalletClient();

  const [yourLoogies, setYourLoogies] = useState<any[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(true);

  const { data: balance, isLoading: isBalanceLoading } = useScaffoldContractRead({
    contractName: "SpaceLoogie",
    functionName: "balanceOf",
    args: [connectedAddress],
  });

  const { data: loogieContract } = useScaffoldContract({ contractName: "YourCollectible", walletClient });

  const { data: spaceContract } = useScaffoldContract({ contractName: "SpaceLoogie", walletClient });

  useEffect(() => {
    const updateYourLoogies = async () => {
      setIsYourLoogiesLoading(true);
      if (connectedAddress && balance && spaceContract) {
        const tokenIds = await spaceContract.read.tokenIdsFromOwner([connectedAddress]);

        console.log("tokenIds", tokenIds);

        const collectibleUpdate: any[] = [];

        // for (let tokenIndex = 0; tokenIndex < balance; tokenIndex++) {
        for (let tokenIndex = 0; tokenIndex < tokenIds.length; tokenIndex++) {
          try {
            // const tokenId = await spaceContract.read.tokenOfOwnerByIndex([connectedAddress, BigInt(tokenIndex)]);
            const tokenId = tokenIds[tokenIndex];
            console.log("tokenId", tokenId);
            const tokenURI = await spaceContract.read.tokenURI([tokenId]);
            console.log("tokenURI", tokenURI);
            const jsonManifestString = atob(tokenURI.substring(29));

            try {
              const jsonManifest = JSON.parse(jsonManifestString);
              console.log("jsonManifest", jsonManifest);
              collectibleUpdate.push({ id: tokenId, owner: connectedAddress, ...jsonManifest });
            } catch (e) {
              console.log(e);
            }
          } catch (e) {
            console.log(e);
          }
        }
        setYourLoogies(collectibleUpdate.reverse());
        setIsYourLoogiesLoading(false);
      }
    };
    updateYourLoogies();
  }, [connectedAddress, balance]);

  const handleMint = async (loogieId: bigint) => {
    if (!loogieContract || !spaceContract) {
      notification.error("Contracts not loaded");
      return;
    }

    // TODO: check if it's already approved
    await loogieContract.write.approve([spaceContract.address, loogieId]);
    await spaceContract.write.mintItemWithLoogie([loogieId]);

    notification.success("Minted SpaceLoogie");
  };

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-4xl font-bold">Your SpaceLoogies</span>
          </h1>
          <div className="flex justify-center items-center space-x-2">
            {isBalanceLoading || isYourLoogiesLoading ? (
              <p className="my-2 font-medium">Loading...</p>
            ) : (
              <div>
                <div className="grid grid-cols-4 gap-4">
                  {yourLoogies.map(loogie => {
                    return (
                      <div
                        key={loogie.id}
                        className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl"
                      >
                        <h2 className="text-xl font-bold">{loogie.name}</h2>
                        <img src={loogie.image} alt={loogie.name} className="w-48 h-48" />
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

export default SpaceLoogies;
