"use client";

import React, { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount, useBlockNumber } from "wagmi";
import { Address } from "~~/components/scaffold-eth";

type SpaceLoogieInfo = {
  description: string;
  external_url: string;
  fancyLoogieId: bigint;
  id: string;
  image: string;
  kms: bigint;
  lastSpeedUpdate: bigint;
  loogieId: bigint;
  name: string;
  owner: string;
  speed: bigint;
  tokenId: bigint;
};

const SpaceLoogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  const [loogies, setLoogies] = useState<SpaceLoogieInfo[]>([]);
  const [isLoogiesLoading, setIsLoogiesLoading] = useState(true);

  const {
    data: blockNumber,
    isLoading: isLoadingBlockNumber,
    isSuccess: isSuccessBlockNumber,
  } = useBlockNumber({ watch: true });

  const LoogiesQuery = gql`
    query Tokens {
      tokens(where: { kind: "SpaceLoogie" }, orderBy: "idNumber", orderDirection: "desc") {
        items {
          id
          tokenURI
          kms
          speed
          lastSpeedUpdate
          loogieId
          fancyLoogieId
        }
      }
    }
  `;

  const [{ data: loogiesData }] = useQuery({
    query: LoogiesQuery,
  });

  console.log("loogiesData", loogiesData);

  useEffect(() => {
    const updateLoogies = async () => {
      setIsLoogiesLoading(true);
      if (loogiesData && loogiesData.tokens.items.length > 0) {
        const collectibleUpdate: SpaceLoogieInfo[] = [];
        const loogies = loogiesData.tokens.items;
        for (let tokenIndex = 0; tokenIndex < loogies.length; tokenIndex++) {
          try {
            const loogieData = loogies[tokenIndex];
            const id = loogieData.id;
            const tokenId = BigInt(id.split(":")[1]);
            const tokenURI = loogieData.tokenURI;
            const jsonManifestString = atob(tokenURI.substring(29));
            const kms = BigInt(loogieData.kms);
            const speed = BigInt(loogieData.speed);
            const lastSpeedUpdate = BigInt(loogieData.lastSpeedUpdate);
            const loogieId = BigInt(loogieData.loogieId);
            const fancyLoogieId = BigInt(loogieData.fancyLoogieId);

            try {
              const jsonManifest = JSON.parse(jsonManifestString);
              collectibleUpdate.push({
                id,
                tokenId,
                kms: kms as bigint,
                speed: speed as bigint,
                lastSpeedUpdate: lastSpeedUpdate as bigint,
                loogieId: loogieId as bigint,
                fancyLoogieId: fancyLoogieId as bigint,
                owner: connectedAddress,
                ...jsonManifest,
              });
            } catch (e) {
              console.log(e);
            }
          } catch (e) {
            console.log(e);
          }
        }
        setLoogies(collectibleUpdate);
      } else {
        setLoogies([]);
      }
      setIsLoogiesLoading(false);
    };
    updateLoogies();
  }, [loogiesData]);

  return (
    <>
      <div className="flex items-center flex-col flex-grow">
        <div className="px-5">
          <div className="flex justify-center items-center space-x-2">
            {isLoogiesLoading ? (
              <p className="my-2 font-medium">Loading...</p>
            ) : (
              <div>
                <div className="text-center pb-2">
                  <p>
                    <Link href="/mySpaceLoogies" className="btn btn-primary text-xl">
                      Mint Spaceship
                    </Link>
                  </p>
                </div>
                <div className="grid sm:grid-cols-4 grid-cols-1 gap-16">
                  {loogies.map(loogie => {
                    return (
                      <div
                        key={loogie.name}
                        className="flex flex-col bg-base-100 p-8 text-center items-center max-w-xs rounded-2xl border-2 border-black"
                      >
                        <h2 className="text-xl font-bold border-2 border-black rounded-2xl p-2 -mb-6 bg-white z-20">
                          {loogie.name}
                        </h2>
                        <Image
                          src={loogie.image}
                          alt={loogie.name}
                          width="300"
                          height="300"
                          className="border-2 border-black rounded-3xl p-6 pt-6 bg-gray-200"
                        />
                        <h3 className="text-xl font-bold border-2 border-black rounded-2xl p-2 -mt-6 bg-white z-20">
                          <Address address={loogie.owner} />
                        </h3>
                        <div className="text-left w-full">
                          <p className="mt-2 mb-2">
                            <span className="font-bold">Distance:</span>
                            {isLoadingBlockNumber || !isSuccessBlockNumber || !blockNumber ? (
                              <span className="loading loading-infinity"></span>
                            ) : (
                              ` ${(loogie.kms + (blockNumber - loogie.lastSpeedUpdate) * loogie.speed).toString()} KMs`
                            )}
                          </p>
                          <p className="mt-2">
                            <span className="font-bold">Speed:</span> {loogie.speed.toString()} KMs/block
                          </p>
                        </div>
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
