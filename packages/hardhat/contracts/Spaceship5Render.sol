//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Spaceship5Render {
	using Strings for uint256;

	function getColors(
		uint256 style
	) internal pure returns (string[10] memory) {
		if (style == 0) {
			string[10] memory colors = [
				"f2f2f2",
				"666",
				"fff",
				"999",
				"1a1a1a",
				"4d4d4d",
				"999",
				"1a1a1a",
				"4d4d4d",
				"333"
			];
			return colors;
		} else if (style == 1) {
			string[10] memory colors = [
				"ccc",
				"000",
				"666",
				"1a1a1a",
				"999",
				"fff",
				"e6e6e6",
				"999",
				"e6e6e6",
				"333"
			];
			return colors;
		} else if (style == 2) {
			string[10] memory colors = [
				"9ae4da",
				"083330",
				"059ca0",
				"056b68",
				"059ca0",
				"00dbdb",
				"00dbdb",
				"059ca0",
				"00dbdb",
				"083330"
			];
			return colors;
		} else if (style == 3) {
			string[10] memory colors = [
				"c5f9d0",
				"083330",
				"39b54a",
				"056b68",
				"056b68",
				"e5f97b",
				"e5f97b",
				"1a1a1a",
				"e5f97b",
				"083330"
			];
			return colors;
		} else if (style == 4) {
			string[10] memory colors = [
				"fbcdb8",
				"222844",
				"dd0aac",
				"395175",
				"dd0aac",
				"f27e8b",
				"fbcdb8",
				"fbcdb8",
				"fbcdb8",
				"412951"
			];
			return colors;
		} else {
			string[10] memory colors = [
				"ffffea",
				"ed1c24",
				"ffb93b",
				"ff4803",
				"c1272d",
				"9b0e00",
				"ffb93b",
				"ff4803",
				"ff4803",
				"412951"
			];
			return colors;
		}
	}

	function renderStyle(
		string[10] memory colors
	) internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".cls-1 {",
			"fill: url(#radial-gradient);",
			"opacity: .65;",
			"}",
			".cls-1,",
			".cls-2,",
			".cls-3,",
			".cls-4,",
			".cls-5,",
			".cls-6,",
			".cls-7,",
			".cls-8,",
			".cls-9 {",
			"stroke-width: 0px;",
			"}",
			".cls-2 {",
			"fill: url(#linear-gradient);",
			"}",
			".cls-3 {",
			"fill: url(#linear-gradient-4);",
			"}",
			".cls-4 {",
			"fill: url(#linear-gradient-2);",
			"}",
			".cls-5 {",
			"fill: url(#linear-gradient-3);",
			"}",
			".cls-6 {",
			"fill: url(#linear-gradient-5);",
			"}",
			".cls-7 {",
			"fill: url(#linear-gradient-6);",
			"}",
			".cls-8 {",
			"fill: #",
			colors[8],
			";",
			"}",
			".cls-9 {",
			"fill: #",
			colors[9],
			";",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render1(
		string[10] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<radialGradient id="radial-gradient" cx="598.13" cy="484.19" fx="598.13" fy="484.19" r="368.2" gradientTransform="" gradientUnits="userSpaceOnUse">',
			'<stop offset=".5" stop-color="#fafefd" stop-opacity=".04" />',
			'<stop offset=".95" stop-color="#',
			colors[0],
			'" />',
			"</radialGradient>",
			'<linearGradient id="linear-gradient" x1="529.44" y1="938.17" x2="668.93" y2="16.24" gradientUnits="userSpaceOnUse">',
			'<stop offset=".02" stop-color="#',
			colors[1],
			'" />',
			'<stop offset=".46" stop-color="#',
			colors[2],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[3],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-2" x1="598.13" y1="113" x2="598.13" y2="853.52" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[6],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[4],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-3" x1="1123.2" y1="478.25" x2="1053.71" y2="478.25" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[7],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[5],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-4" x1="1181.9" y1="509.72" x2="1127.07" y2="451.67" xlink:href="#linear-gradient-3" />',
			'<linearGradient id="linear-gradient-5" x1="69.68" y1="478.25" x2="144.88" y2="478.25" xlink:href="#linear-gradient-3" />',
			'<linearGradient id="linear-gradient-6" x1="280.06" y1="509.72" x2="225.23" y2="451.67" gradientTransform="translate(295.31) rotate(-180) scale(1 -1)" xlink:href="#linear-gradient-3" />'
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[10] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(colors),
			render1(colors),
			"</defs>",
			'<g id="Globe_',
			style.toString(),
			'">',
			'<path class="cls-9" d="m596.49,32.91c-227.57,0-412.05,184.48-412.05,412.05s184.48,412.05,412.05,412.05,412.05-184.48,412.05-412.05S824.06,32.91,596.49,32.91Zm0,736.54c-179.21,0-324.49-145.28-324.49-324.49S417.28,120.46,596.49,120.46s324.49,145.28,324.49,324.49-145.28,324.49-324.49,324.49Z" />',
			'<circle class="cls-1" cx="598.13" cy="484.19" r="367.47" />',
			'<path class="cls-2" d="m598.13,17.57c-257.71,0-466.62,208.91-466.62,466.62s208.91,466.62,466.62,466.62,466.62-208.91,466.62-466.62S855.84,17.57,598.13,17.57Zm0,834.09c-202.95,0-367.47-164.52-367.47-367.47S395.18,116.72,598.13,116.72s367.47,164.52,367.47,367.47-164.52,367.47-367.47,367.47Z" />',
			'<path class="cls-4" d="m598.13,126.72c48.26,0,95.08,9.45,139.14,28.09,42.57,18,80.8,43.78,113.63,76.61s58.61,71.06,76.61,113.63c18.64,44.06,28.09,90.88,28.09,139.14s-9.45,95.08-28.09,139.14c-18,42.57-43.78,80.8-76.61,113.63-32.83,32.83-71.06,58.61-113.63,76.61-44.06,18.64-90.88,28.09-139.14,28.09s-95.08-9.45-139.14-28.09c-42.57-18-80.8-43.78-113.63-76.61-32.83-32.83-58.61-71.06-76.61-113.63-18.64-44.06-28.09-90.88-28.09-139.14s9.45-95.08,28.09-139.14c18-42.57,43.78-80.8,76.61-113.63,32.83-32.83,71.06-58.61,113.63-76.61,44.06-18.64,90.88-28.09,139.14-28.09m0-10c-202.95,0-367.47,164.52-367.47,367.47s164.52,367.47,367.47,367.47,367.47-164.52,367.47-367.47S801.08,116.72,598.13,116.72h0Z" />',
			'<rect class="cls-5" x="1049.47" y="473.36" width="101.41" height="9.78" rx="4.89" ry="4.89" />',
			'<circle class="cls-3" cx="1152.17" cy="478.25" r="35.52" />',
			'<path class="cls-6" d="m50.35,483.14h88.82c2.7,0,4.89-2.19,4.89-4.89h0c0-2.7-2.19-4.89-4.89-4.89H50.35s0,9.78,0,9.78Z" />',
			'<circle class="cls-7" cx="44.98" cy="478.25" r="35.52" />',
			'<path class="cls-8" d="m182.7,535.83c9.43-15.5,14.62-36.05,14.62-57.85s-5.19-42.35-14.62-57.85c-9.71-15.96-22.77-24.75-36.78-24.75-2.03,0-4.06.19-6.07.57-.4,2.11-.79,4.22-1.16,6.34,2.39-.65,4.81-.98,7.24-.98,25.07,0,45.47,34.4,45.47,76.68s-20.4,76.68-45.47,76.68c-3.15,0-6.29-.56-9.36-1.66.32,2.17.66,4.34,1.01,6.51,2.75.71,5.54,1.08,8.35,1.08,14.01,0,27.07-8.79,36.78-24.75Z" />',
			'<path class="cls-8" d="m1050.77,554.66c-25.07,0-45.47-34.4-45.47-76.68s20.4-76.68,45.47-76.68c2.28,0,4.55.31,6.79.88-.37-2.11-.76-4.22-1.16-6.32-1.87-.32-3.75-.49-5.63-.49-14.01,0-27.07,8.79-36.78,24.75-9.43,15.5-14.62,36.05-14.62,57.85s5.19,42.35,14.62,57.85c9.71,15.96,22.77,24.75,36.78,24.75,2.66,0,5.3-.33,7.91-.97.35-2.15.68-4.3,1-6.46-2.92.99-5.91,1.5-8.91,1.5Z" />',
			"</g>"
		);

		return renderText;
	}
}
