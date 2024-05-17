"use client";

import React, { useEffect, useState } from "react";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { useWalletClient } from "wagmi";
import { useScaffoldContract, useScaffoldContractRead } from "~~/hooks/scaffold-eth";
import { notification } from "~~/utils/scaffold-eth";

const Space: NextPage = () => {
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
              collectibleUpdate.push({
                id: tokenId,
                owner: connectedAddress,
                top: Math.floor(Math.random() * 800),
                left: Math.floor(Math.random() * 1800),
                ...jsonManifest,
              });
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

  return (
    <>
      <div className="bg"></div>

      <div className="star-field">
        <div className="layer"></div>
        <div className="layer"></div>
        <div className="layer"></div>
      </div>

      {yourLoogies.map(loogie => {
        return (
          <img
            src={loogie.image}
            alt={loogie.name}
            className="w-24 h-24 relative move-x"
            style={{ top: loogie.top, left: loogie.left }}
          />
        );
      })}
    </>
  );
};

export default Space;
