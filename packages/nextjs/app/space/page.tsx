"use client";

import React, { useEffect, useState } from "react";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount } from "wagmi";

const Space: NextPage = () => {
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
  console.log("isYourLoogiesLoading", isYourLoogiesLoading);

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
              collectibleUpdate.push({
                id,
                tokenId,
                kind,
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
      {!isYourLoogiesLoading &&
        yourLoogies.map(loogie => {
          return (
            <img
              key={loogie.id}
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
