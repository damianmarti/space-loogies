"use client";

import React, { useEffect, useState } from "react";
import Image from "next/image";
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

const Leaderboard: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  const [loogies, setLoogies] = useState<SpaceLoogieInfo[]>([]);
  const [sortedLoogies, setSortedLoogies] = useState<SpaceLoogieInfo[]>([]);
  const [isLoogiesLoading, setIsLoogiesLoading] = useState(true);

  const {
    data: blockNumber,
    isLoading: isLoadingBlockNumber,
    isSuccess: isSuccessBlockNumber,
  } = useBlockNumber({ watch: true });

  const LoogiesQuery = gql`
    query Tokens {
      tokens(where: { kind: "SpaceLoogie" }) {
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
        console.log("collectibleUpdate", collectibleUpdate);
        collectibleUpdate.sort((a, b) => (a.kms < b.kms ? -1 : 1));
        console.log("collectibleUpdate sorted", collectibleUpdate);
        setLoogies(collectibleUpdate);
      } else {
        setLoogies([]);
      }
      setIsLoogiesLoading(false);
    };
    updateLoogies();
  }, [loogiesData]);

  useEffect(() => {
    const sortLoogies = async () => {
      if (loogies.length > 0 && blockNumber !== undefined) {
        setSortedLoogies(
          [...loogies].sort((a, b) =>
            a.kms + (blockNumber - a.lastSpeedUpdate) * a.speed > b.kms + (blockNumber - b.lastSpeedUpdate) * b.speed
              ? -1
              : 1,
          ),
        );
      }
    };
    sortLoogies();
  }, [loogies, blockNumber]);

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <div className="flex justify-center items-center space-x-2">
            {isLoogiesLoading ? (
              <p className="my-2 font-medium">Loading...</p>
            ) : (
              <div className="bg-white rounded-xl p-8">
                <table>
                  <thead className="border-b-2">
                    <tr>
                      <th className="p-2">Rank</th>
                      <th className="p-2">Ship</th>
                      <th className="p-2">Owner</th>
                      <th className="p-2">
                        Speed
                        <br />
                        (KM/block)
                      </th>
                      <th className="p-2">
                        Distance
                        <br />
                        (KM)
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    {sortedLoogies.map((loogie, index) => {
                      return (
                        <tr className="pt-4" key={loogie.name}>
                          <td className="font-bold text-4xl text-center p-4">
                            <div className="rounded-xl bg-primary p-2 border-2 border-black">{index + 1}</div>
                          </td>
                          <td>
                            <Image
                              src={loogie.image}
                              alt={loogie.name}
                              width="150"
                              height="150"
                              className="border-2 border-black rounded-3xl p-6 pt-6 bg-gray-200 mt-4"
                            />
                          </td>
                          <td className="p-4">
                            <div className="text-center mb-2 text-xl">{loogie.name}</div>
                            <div className="border-2 border-black rounded-2xl p-2 bg-secondary">
                              <Address address={loogie.owner} disableAddressCopy={true} />
                            </div>
                          </td>
                          <td className="text-right text-2xl p-2">{loogie.speed.toString()}</td>
                          <td className="text-right text-4xl p-2 font-bold">
                            {isLoadingBlockNumber || !isSuccessBlockNumber || !blockNumber ? (
                              <span className="loading loading-infinity"></span>
                            ) : (
                              ` ${(loogie.kms + (blockNumber - loogie.lastSpeedUpdate) * loogie.speed).toString()}`
                            )}
                          </td>
                        </tr>
                      );
                    })}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      </div>
    </>
  );
};

export default Leaderboard;
