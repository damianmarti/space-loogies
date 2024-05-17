//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Propulsion2Render {
	using Strings for uint256;

	function getColors(uint256 style) internal pure returns (string[2] memory) {
		if (style == 0) {
			string[2] memory colors = ["3da152", "8cc63f"];
			return colors;
		} else if (style == 1) {
			string[2] memory colors = ["dd0aac", "93278f"];
			return colors;
		} else if (style == 2) {
			string[2] memory colors = ["00dbdb", "059ca0"];
			return colors;
		} else if (style == 3) {
			string[2] memory colors = ["ff1b2f", "860074"];
			return colors;
		} else {
			string[2] memory colors = ["ffb93b", "ff3a03"];
			return colors;
		}
	}

	function renderStyle() internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".pcls-1 {",
			"fill: url(#p-linear-gradient);",
			"}",
			".pcls-1,",
			".pcls-2,",
			".pcls-3 {",
			"stroke-width: 0px;",
			"}",
			".pcls-2 {",
			"fill: url(#p-linear-gradient-2);",
			"}",
			".pcls-3 {",
			"fill: url(#p-linear-gradient-3);",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[2] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(),
			'<linearGradient id="p-linear-gradient" x1="564.11" y1="977.72" x2="564.11" y2="1537.72" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[0],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[1],
			'" />',
			"</linearGradient>",
			'<linearGradient id="p-linear-gradient-2" x1="355.64" y1="977.72" x2="355.64" y2="1537.72" xlink:href="#p-linear-gradient" />',
			'<linearGradient id="p-linear-gradient-3" x1="842.95" y1="977.72" x2="842.95" y2="1537.72" xlink:href="#p-linear-gradient" />            ',
			"</defs>",
			'<g id="Gas_',
			style.toString(),
			'">',
			'<path class="pcls-1" d="m702.61,1270.39c.94-4.56,1.44-9.29,1.44-14.14,0-35.48-26.59-64.72-60.92-68.95-1.34-8.41-4.46-16.22-8.96-23.03,21.09-8.91,35.89-29.78,35.89-54.11,0-19.42-9.44-36.64-23.98-47.32,3.03-6.08,4.74-12.93,4.74-20.18,0-25.03-20.29-45.33-45.33-45.33-19.23,0-35.65,11.98-42.23,28.87-3.38-.6-6.85-.94-10.4-.94-32.42,0-58.71,26.29-58.71,58.71,0,10.94,3,21.18,8.22,29.95-7.39,9.82-11.77,22.03-11.77,35.26,0,2.38.16,4.73.43,7.04-1.1-.04-2.19-.07-3.3-.07-42.95,0-78.68,30.88-86.22,71.65-32.11.36-58.04,26.49-58.04,58.69s26.28,58.71,58.71,58.71c2.77,0,5.49-.21,8.16-.58,14.63,28.04,43.97,47.18,77.78,47.18,9.55,0,18.73-1.53,27.34-4.35,1.97,24.03,20.69,43.3,44.47,46.11-6.02,11.45-9.45,24.48-9.45,38.32,0,45.54,36.91,82.45,82.45,82.45s82.45-36.91,82.45-82.45c0-6.07-.68-11.99-1.92-17.68,40.91-10.02,71.27-46.92,71.27-90.91,0-47.81-35.85-87.24-82.13-92.9Z" />',
			'<path class="pcls-2" d="m403.32,1425.2c-11.77-7.42-25.63-8.75-37.93-4.84.06-11.62-5.7-23.01-16.25-29.66-16.27-10.26-37.78-5.39-48.04,10.88-6.44,10.21-6.92,22.47-2.36,32.73-2.57,2.17-4.86,4.76-6.75,7.76-9.9,15.7-5.2,36.44,10.5,46.34,12.05,7.6,27.07,6.58,37.88-1.39,3.53,5.84,8.43,10.98,14.6,14.87,21.18,13.35,49.17,7.01,62.52-14.16,13.35-21.18,7.01-49.17-14.16-62.52Z" />',
			'<path class="pcls-3" d="m880.5,1280.92c3.35-4.69,6-10.01,7.7-15.86,8.15-27.92-7.87-57.16-35.8-65.32s-57.16,7.87-65.32,35.8c-8.13,27.83,7.78,56.97,35.53,65.23-.53,1.3-1,2.64-1.4,4.02-6.29,21.56,6.08,44.14,27.64,50.43,21.56,6.29,44.14-6.08,50.43-27.64,5.37-18.4-2.86-37.53-18.79-46.66Z" />',
			"</g>"
		);

		return renderText;
	}
}
