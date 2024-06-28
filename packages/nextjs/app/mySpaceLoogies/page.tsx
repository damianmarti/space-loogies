"use client";

import React, { useEffect, useState } from "react";
import Image from "next/image";
import Link from "next/link";
import type { NextPage } from "next";
import { gql, useQuery } from "urql";
import { useAccount, useBlockNumber } from "wagmi";
import { useDeployedContractInfo, useScaffoldContractRead, useScaffoldContractWrite } from "~~/hooks/scaffold-eth";

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

const MySpaceLoogies: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  const [yourLoogies, setYourLoogies] = useState<SpaceLoogieInfo[]>([]);
  const [isYourLoogiesLoading, setIsYourLoogiesLoading] = useState(true);
  const [speedUpAmount, setSpeedUpAmount] = useState(1);
  const [currentSpaceshipId, setCurrentSpaceshipId] = useState<bigint>(0n);
  const [currentLoogieId, setCurrentLoogieId] = useState<bigint>(0n);
  const [currentFancyLoogieId, setCurrentFancyLoogieId] = useState<bigint>(0n);
  const [isSpeedUpModalOpen, setIsSpeedUpModalOpen] = useState(false);
  const [isSpeedingUp, setIsSpeedingUp] = useState(false);
  const [isEjectLoogieModalOpen, setIsEjectLoogieModalOpen] = useState(false);
  const [isEjectingLoogie, setIsEjectingLoogie] = useState(false);
  const [isSendingLoogieModalOpen, setIsSendingLoogieModalOpen] = useState(false);

  const {
    data: blockNumber,
    isLoading: isLoadingBlockNumber,
    isSuccess: isSuccessBlockNumber,
  } = useBlockNumber({ watch: true });
  console.log("blockNumber", blockNumber);

  const { data: loogieCoinBalance } = useScaffoldContractRead({
    contractName: "LoogieCoin",
    functionName: "balanceOf",
    args: [connectedAddress],
  });

  const { writeAsync: speedUpSpaceship } = useScaffoldContractWrite({
    contractName: "SpaceLoogie",
    functionName: "speedUp",
    args: [currentSpaceshipId, BigInt(speedUpAmount)],
  });

  const { writeAsync: getOriginalLoogie } = useScaffoldContractWrite({
    contractName: "SpaceLoogie",
    functionName: "getOriginalLoogie",
    args: [currentSpaceshipId],
  });

  const { data: spaceLoogieContractInfo } = useDeployedContractInfo("SpaceLoogie");

  const { writeAsync: loogieSafeTransferFrom } = useScaffoldContractWrite({
    contractName: "YourCollectible",
    functionName: "safeTransferFrom",
    // @ts-ignore
    args: [
      connectedAddress,
      spaceLoogieContractInfo?.address,
      currentLoogieId,
      `0x${currentSpaceshipId.toString(16).padStart(64, "0")}`,
    ],
  });

  const { writeAsync: fancyLoogieSafeTransferFrom } = useScaffoldContractWrite({
    contractName: "FancyLoogie",
    functionName: "safeTransferFrom",
    // @ts-ignore
    args: [
      connectedAddress,
      spaceLoogieContractInfo?.address,
      currentLoogieId,
      `0x${currentSpaceshipId.toString(16).padStart(64, "0")}`,
    ],
  });

  const LoogiesQuery = gql`
    query Tokens($owner: String) {
      tokens(where: { ownerId: $owner, kind: "SpaceLoogie" }) {
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

  const [{ data: loogiesData }, reexecuteLoogiesQuery] = useQuery({
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
        setYourLoogies(collectibleUpdate.reverse());
      } else {
        setYourLoogies([]);
      }
      setIsYourLoogiesLoading(false);
    };
    updateYourLoogies();
  }, [loogiesData]);

  const sleep = (ms: number) => new Promise(r => setTimeout(r, ms));

  const handleSpeedUp = async () => {
    await speedUpSpaceship();
    setIsSpeedUpModalOpen(false);
    setIsSpeedingUp(true);
    await sleep(5000);
    reexecuteLoogiesQuery({ requestPolicy: "network-only" });
    setIsSpeedingUp(false);
  };

  const handleEjectLoogie = async () => {
    await getOriginalLoogie();
    setIsEjectLoogieModalOpen(false);
    setIsEjectingLoogie(true);
    await sleep(5000);
    reexecuteLoogiesQuery({ requestPolicy: "network-only" });
    setIsEjectingLoogie(false);
  };

  const handleSendLoogie = async () => {
    if (currentLoogieId !== 0n) {
      await loogieSafeTransferFrom();
    } else {
      await fancyLoogieSafeTransferFrom();
    }
    setIsSendingLoogieModalOpen(false);
    setIsEjectingLoogie(true);
    await sleep(5000);
    reexecuteLoogiesQuery({ requestPolicy: "network-only" });
    setIsEjectingLoogie(false);
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
                    <p className="font-bold">You don&apos;t have any Spaceships yet.</p>
                    <p className="mt-8">
                      Mint a free Spaceship for each of your <span className="font-bold">Loogies</span> or{" "}
                      <span className="font-bold">FancyLoogies</span>.
                    </p>
                    <p className="mt-16">
                      <Link href="/myLoogies" className="btn btn-primary text-xl">
                        Mint Spaceship
                      </Link>
                    </p>
                  </div>
                ) : (
                  <div className="grid grid-cols-4 gap-16">
                    {yourLoogies.map(loogie => {
                      return (
                        <div className="indicator" key={loogie.id}>
                          <div className="indicator-item indicator-top">
                            {loogie.speed > 0 ? (
                              <div className="tooltip" data-tip="Eject Loogie">
                                <button
                                  className="btn btn-primary border-2 border-black px-6"
                                  onClick={() => {
                                    setCurrentSpaceshipId(loogie.tokenId);
                                    setIsEjectLoogieModalOpen(true);
                                  }}
                                >
                                  ⏏
                                </button>
                              </div>
                            ) : (
                              <div className="tooltip" data-tip="Send Loogie">
                                <button
                                  className="btn btn-primary"
                                  onClick={() => {
                                    setCurrentSpaceshipId(loogie.tokenId);
                                    setCurrentLoogieId(loogie.loogieId);
                                    setCurrentFancyLoogieId(loogie.fancyLoogieId);
                                    setIsSendingLoogieModalOpen(true);
                                  }}
                                >
                                  📥
                                </button>
                              </div>
                            )}
                          </div>
                          <div className="flex flex-col bg-base-100 p-8 text-center items-center max-w-xs rounded-2xl border-2 border-black">
                            <h2 className="text-xl font-bold border-2 border-black rounded-2xl p-2 -mb-6 bg-white z-20">
                              {loogie.name}
                            </h2>
                            {isEjectingLoogie ? (
                              <span className="loading loading-ring loading-lg"></span>
                            ) : (
                              <Image
                                src={loogie.image}
                                alt={loogie.name}
                                width="300"
                                height="300"
                                className="border-2 border-black rounded-3xl p-2 pt-6 bg-gray-200"
                              />
                            )}
                            <div className="text-left w-full">
                              <p className="mt-4 mb-2">
                                <span className="font-bold">Distance:</span>
                                {isLoadingBlockNumber || !isSuccessBlockNumber || !blockNumber ? (
                                  <span className="loading loading-infinity"></span>
                                ) : (
                                  ` ${(
                                    loogie.kms +
                                    (blockNumber - loogie.lastSpeedUpdate) * loogie.speed
                                  ).toString()} KMs`
                                )}
                              </p>
                              <p className="mt-2 mb-6">
                                <span className="font-bold">Speed:</span>{" "}
                                {isSpeedingUp ? (
                                  <span className="loading loading-infinity"></span>
                                ) : (
                                  loogie.speed.toString()
                                )}{" "}
                                KMs/block
                              </p>
                              <div className="text-center">
                                <div className="tooltip" data-tip="Speed Up">
                                  <button
                                    onClick={() => {
                                      setCurrentSpaceshipId(loogie.tokenId);
                                      setIsSpeedUpModalOpen(true);
                                    }}
                                    className="btn btn-primary text-3xl"
                                  >
                                    🚀
                                  </button>
                                </div>
                              </div>
                            </div>
                          </div>
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
      <dialog id="modal-speed-up" className="modal text-center" open={isSpeedUpModalOpen}>
        <div className="modal-box">
          <button
            className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
            onClick={() => setIsSpeedUpModalOpen(false)}
          >
            ✕
          </button>
          <h3 className="font-bold text-lg">SpaceLoogie #{currentSpaceshipId.toString()}</h3>
          <div className="m-4">
            Speed up:
            <input
              type="number"
              className="border border-gray-300 p-1 w-20 ml-2"
              value={speedUpAmount}
              onChange={e => setSpeedUpAmount(Number(e.target.value))}
            />
            <p>
              <span className="text-red-400"></span>
              <div
                className={`${
                  loogieCoinBalance !== undefined && loogieCoinBalance < speedUpAmount * 1000
                    ? "text-red-400"
                    : "text-green-600"
                }`}
              >
                <p className="mb-2">Cost: {speedUpAmount * 1000} LoogieCoins</p>
                <p className="mt-2">(Balance: {loogieCoinBalance?.toString()})</p>
              </div>
            </p>
            <button
              onClick={handleSpeedUp}
              className="btn btn-primary"
              disabled={loogieCoinBalance === undefined || loogieCoinBalance < speedUpAmount * 1000}
            >
              Speed Up!
            </button>
          </div>
        </div>
      </dialog>
      <dialog id="modal-eject-loogie" className="modal text-center" open={isEjectLoogieModalOpen}>
        <div className="modal-box">
          <button
            className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
            onClick={() => setIsEjectLoogieModalOpen(false)}
          >
            ✕
          </button>
          <h3 className="font-bold text-lg">SpaceLoogie #{currentSpaceshipId.toString()}</h3>
          <div className="m-4">
            <p>You can eject your loogie from the spaceship and your loogie will be transferred to your account.</p>
            <p>The spaceship will stop and the speed will be reset to 0.</p>
            <p>You can send it later again to the spaceship, but only this loogie can drive this spaceship.</p>
            <button onClick={() => setIsEjectLoogieModalOpen(false)} className="btn btn-secondary mr-16">
              Cancel
            </button>
            <button onClick={handleEjectLoogie} className="btn btn-primary">
              Eject!
            </button>
          </div>
        </div>
      </dialog>
      <dialog id="modal-send-loogie" className="modal text-center" open={isSendingLoogieModalOpen}>
        <div className="modal-box">
          <button
            className="btn btn-sm btn-circle btn-ghost absolute right-2 top-2"
            onClick={() => setIsSendingLoogieModalOpen(false)}
          >
            ✕
          </button>
          <h3 className="font-bold text-lg">SpaceLoogie #{currentSpaceshipId.toString()}</h3>
          <div className="m-4">
            <p>
              Send your {currentLoogieId !== 0n ? `Loogie #${currentLoogieId}` : `FancyLoogie #${currentFancyLoogieId}`}{" "}
              to your spaceship.
            </p>
            <button onClick={() => setIsSendingLoogieModalOpen(false)} className="btn btn-secondary mr-16">
              Cancel
            </button>
            <button onClick={handleSendLoogie} className="btn btn-primary">
              Send!
            </button>
          </div>
        </div>
      </dialog>
    </>
  );
};

export default MySpaceLoogies;
