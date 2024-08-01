"use client";

import React from "react";
import Link from "next/link";
import type { NextPage } from "next";
import { OptimisticLoogiesLogoIcon } from "~~/components/assets/OptimisticLoogiesLogoIcon";
import { SpaceLoogiesLogoFull } from "~~/components/assets/SpaceLoogiesLogoFull";

const About: NextPage = () => {
  return (
    <>
      <div className="m-4 text-xl bg-secondary border-2 border-black rounded-2xl p-8 text-center">
        <h1 className="text-3xl font-bold mb-8">Welcome to the LoogieVerse!!</h1>
        <p className="text-2xl">
          The <span className="font-bold">LoogieVerse</span> is a universe of Loogies, accessories for your Loogies,
          Ships, Spaceships, and more.
        </p>
        <p className="text-2xl mt-8">
          All are <span className="font-bold">on-chain SVG NFTs</span> you can collect, trade, and use in the
          LoogieVerse.
        </p>
        <p className="text-2xl mt-8">
          The journey starts with your first <span className="font-bold">OptimisticLoogie</span>!
        </p>
        <p className="mt-16">
          Starts minting a <span className="font-bold">OptimiticLoogie</span>.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link href="https://optimistic.loogies.io" target="_blank" className="btn btn-primary text-xl p-4 px-24 h-24">
            <OptimisticLoogiesLogoIcon />
          </Link>
        </p>
        <p className="mt-16">
          Then you can mint a <span className="font-bold">Spaceship</span> for free.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link href="/myLoogies" target="_blank" className="btn btn-primary text-xl p-4 h-24 flex flex-col w-80">
            <img src="/spaceship-logo.svg" width={70} height={70} />
            Mint Free Spaceship
          </Link>
        </p>
        <p className="mt-16">
          You can collect <span className="font-bold">LoogieCoins</span> on the LoogieBoard.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link
            href="https://board.fancyloogies.com/"
            target="_blank"
            className="btn btn-primary text-xl h-24 flex flex-col w-96"
          >
            <img src="/loogie-board-small.png" width={200} height={200} className="-ml-4" />
            <span className="-ml-8 text-2xl p-4">LoogieBoard</span>
          </Link>
        </p>
        <p className="mt-16">
          <span className="font-bold">Speed up</span> your Spaceship with LoogieCoins and reach the top of the
          leaderboard.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link href="/mySpaceships" className="btn btn-primary text-xl h-24 w-80">
            <SpaceLoogiesLogoFull />
          </Link>
        </p>
        <p className="mt-16">
          You can upgrade your Loogie to a <span className="font-bold">FancyLoogie</span> and add accessories to your
          Loogie.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link
            href="https://fancyloogies.com/"
            target="_blank"
            className="btn btn-primary text-xl p-4 h-24 flex flex-col w-64"
          >
            <img src="/fancy-loogie.svg" width={100} height={100} className="-ml-4" />
            <span className="-ml-8 text-2xl">FancyLoogies</span>
          </Link>
        </p>
        <p className="mt-16">
          You can go fishing with the <span className="font-bold">SailorLoogies</span>.
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link
            href="https://sailor.fancyloogies.com/"
            target="_blank"
            className="btn btn-primary text-xl p-4 h-24 flex flex-col w-80"
          >
            <img src="/ship-logo.svg" width={100} height={100} className="-ml-4" />
            <span className="-ml-8 text-2xl">SailorLoogies</span>
          </Link>
        </p>
        <p className="mt-16">
          And if you are a LoogieCoin whale, you can mint a{" "}
          <span className="font-bold">super-exclusive Earring NFT</span> for your FancyLoogie!
        </p>
        <p className="mt-4 text-center flex justify-center">
          <Link
            href="https://earrings.fancyloogies.com/"
            target="_blank"
            className="btn btn-primary text-xl p-4 h-24 flex flex-col w-80"
          >
            <img src="/loogie-earring.svg" width={100} height={100} className="-ml-4" />
            <span className="-ml-8 text-2xl">Loogie Earrings</span>
          </Link>
        </p>
      </div>
    </>
  );
};

export default About;
