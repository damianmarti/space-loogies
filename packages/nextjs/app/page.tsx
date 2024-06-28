"use client";

import React, { useEffect, useState } from "react";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount } from "wagmi";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  const [yourLoogies, setYourLoogies] = useState<any[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(true);
  const [startIndex, setStartIndex] = useState(0);

  const shipsPerRound = 5;

  const LoogiesQuery = gql`
    query Tokens($zero: BigInt) {
      tokens(where: { kind: "SpaceLoogie", speed_gt: $zero }) {
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
      zero: 0,
    },
  });

  console.log("loogiesData", loogiesData);

  useEffect(() => {
    const updateYourLoogies = async () => {
      setIsYourLoogiesLoading(true);
      if (loogiesData && loogiesData.tokens.items.length > 0) {
        const collectibleUpdate: any[] = [];
        const loogies = loogiesData.tokens.items;
        for (let tokenIndex = startIndex; tokenIndex < startIndex + shipsPerRound; tokenIndex++) {
          try {
            const realTokenIndex = tokenIndex % loogies.length;
            const id = loogies[realTokenIndex].id;
            const tokenId = id.split(":")[1];
            const kind = loogies[realTokenIndex].kind;
            const tokenURI = loogies[realTokenIndex].tokenURI;
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
        setTimeout(() => {
          setStartIndex(startIndex + shipsPerRound);
        }, 20000);
      } else {
        setYourLoogies([]);
      }
      setIsYourLoogiesLoading(false);
    };
    updateYourLoogies();
  }, [loogiesData, startIndex]);

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

export default Home;
