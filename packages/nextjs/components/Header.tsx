"use client";

import React, { useCallback, useRef, useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { SpaceLoogiesLogoFull } from "./assets/SpaceLoogiesLogoFull";
import { Bars3Icon } from "@heroicons/react/24/outline";
import { FaucetButton, RainbowKitCustomConnectButton } from "~~/components/scaffold-eth";
import { useOutsideClick } from "~~/hooks/scaffold-eth";

type HeaderMenuLink = {
  label: string;
  href: string;
  icon?: React.ReactNode;
};

export const menuLinks: HeaderMenuLink[] = [
  {
    label: "Spaceships",
    href: "/spaceLoogies",
  },
  {
    label: "Leaderboard",
    href: "/leaderboard",
  },
  {
    label: "About",
    href: "/about",
  },
];

export const menuMyLinks: HeaderMenuLink[] = [
  {
    label: "My Spaceships",
    href: "/mySpaceLoogies",
  },
  {
    label: "My Loogies",
    href: "/myLoogies",
  },
];

export const HeaderMenuLinks = () => {
  const pathname = usePathname();

  return (
    <>
      {menuLinks.map(({ label, href, icon }) => {
        const isActive = pathname === href;
        return (
          <li key={href}>
            <Link
              href={href}
              passHref
              className={`${
                isActive ? "bg-primary shadow-md" : "bg-white"
              } hover:bg-primary hover:shadow-md focus:!bg-primary active:!text-neutral py-2 px-6 text-sm rounded-full gap-2 grid grid-flow-col border-2 border-black font-bold mr-2`}
            >
              {icon}
              <span>{label}</span>
            </Link>
          </li>
        );
      })}
    </>
  );
};

export const HeaderMenuMyLinks = () => {
  const pathname = usePathname();

  return (
    <>
      {menuMyLinks.map(({ label, href, icon }) => {
        const isActive = pathname === href;
        return (
          <li key={href}>
            <Link
              href={href}
              passHref
              className={`${
                isActive ? "bg-primary shadow-md" : "bg-white"
              } hover:bg-primary hover:shadow-md focus:!bg-primary active:!text-neutral py-2 px-6 text-sm rounded-full gap-2 grid grid-flow-col border-2 border-black font-bold mr-2`}
            >
              {icon}
              <span>{label}</span>
            </Link>
          </li>
        );
      })}
    </>
  );
};

/**
 * Site header
 */
export const Header = () => {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const burgerMenuRef = useRef<HTMLDivElement>(null);
  useOutsideClick(
    burgerMenuRef,
    useCallback(() => setIsDrawerOpen(false), []),
  );
  const pathname = usePathname();

  return (
    <div className="sticky lg:static top-0 navbar bg-base-100 min-h-0 flex-shrink-0 justify-between z-20 shadow-md shadow-black m-4 sm:px-2 bg-space-blue rounded-2xl w-auto border-2 border-black">
      <div className="navbar-start w-auto">
        <div className="lg:hidden dropdown" ref={burgerMenuRef}>
          <label
            tabIndex={0}
            className={`ml-1 btn btn-ghost ${isDrawerOpen ? "hover:bg-secondary" : "hover:bg-transparent"}`}
            onClick={() => {
              setIsDrawerOpen(prevIsOpenState => !prevIsOpenState);
            }}
          >
            <Bars3Icon className="h-1/2" />
          </label>
          {isDrawerOpen && (
            <ul
              tabIndex={0}
              className="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52"
              onClick={() => {
                setIsDrawerOpen(false);
              }}
            >
              <li>
                <Link
                  href="/"
                  passHref
                  className={`${
                    pathname === "/" ? "bg-primary shadow-md" : "bg-white"
                  } hover:bg-primary hover:shadow-md focus:!bg-primary active:!text-neutral py-2 px-6 text-sm rounded-full gap-2 grid grid-flow-col border-2 border-black font-bold mr-2`}
                >
                  <span>Home</span>
                </Link>
              </li>
              <HeaderMenuLinks />
              <HeaderMenuMyLinks />
            </ul>
          )}
        </div>
        <Link href="/" passHref className="hidden lg:flex items-center gap-2 ml-4 mr-6 shrink-0">
          <div className="flex relative w-48">
            <SpaceLoogiesLogoFull />
          </div>
        </Link>
        <ul className="hidden lg:flex lg:flex-nowrap menu menu-horizontal px-1 gap-2 mr-8">
          <HeaderMenuLinks />
        </ul>
      </div>
      <div className="navbar-end flex-grow mr-4">
        <ul className="hidden lg:flex lg:flex-nowrap menu menu-horizontal px-1 gap-2 ml-8">
          <HeaderMenuMyLinks />
        </ul>
        <RainbowKitCustomConnectButton />
        <FaucetButton />
      </div>
    </div>
  );
};
