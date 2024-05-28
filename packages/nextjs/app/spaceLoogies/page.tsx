"use client";

import React, { useEffect, useState } from "react";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount } from "wagmi";

const SpaceLoogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  const [yourLoogies, setYourLoogies] = useState<any[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(true);

  const LoogiesQuery = gql`
    query Tokens($owner: String) {
      tokens(where: { ownerId: $owner, kind: "SpaceLoogie" }) {
        items {
          id
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

  useEffect(() => {
    const updateYourLoogies = async () => {
      setIsYourLoogiesLoading(true);
      if (loogiesData && loogiesData.tokens.items.length > 0) {
        const collectibleUpdate: any[] = [];
        const loogies = loogiesData.tokens.items;
        for (let tokenIndex = 0; tokenIndex < loogies.length; tokenIndex++) {
          try {
            const id = loogies[tokenIndex].id;
            const tokenId = id.split(":")[1];
            const kind = loogies[tokenIndex].kind;
            const tokenURI = loogies[tokenIndex].tokenURI;
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

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-4xl font-bold">Your SpaceLoogies</span>
          </h1>
          <div className="flex justify-center items-center space-x-2">
            {isYourLoogiesLoading ? (
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
