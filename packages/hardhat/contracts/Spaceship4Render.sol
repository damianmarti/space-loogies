//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Spaceship4Render {
	using Strings for uint256;

	function getColors(uint256 style) internal pure returns (string[6] memory) {
		if (style == 0) {
			string[6] memory colors = [
				"ce7924",
				"ffdc7c",
				"603813",
				"ffb93b",
				"ff3a03",
				"ffe5ab"
			];
			return colors;
		} else if (style == 1) {
			string[6] memory colors = [
				"083330",
				"059ca0",
				"222844",
				"056b68",
				"8cc63f",
				"c5f9d0"
			];
			return colors;
		} else if (style == 2) {
			string[6] memory colors = [
				"412951",
				"dd0aac",
				"222844",
				"6f007b",
				"f27e8b",
				"c8a5db"
			];
			return colors;
		} else if (style == 3) {
			string[6] memory colors = [
				"083330",
				"059ca0",
				"083330",
				"056b68",
				"059ca0",
				"9ae4da"
			];
			return colors;
		} else if (style == 4) {
			string[6] memory colors = [
				"1a1a1a",
				"b3b3b3",
				"1a1a1a",
				"ccc",
				"666",
				"9ae4da"
			];
			return colors;
		} else {
			string[6] memory colors = [
				"4d4d4d",
				"ccc",
				"1a1a1a",
				"808080",
				"1a1a1a",
				"9ae4da"
			];
			return colors;
		}
	}

	function renderStyle() internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".cls-1 {",
			"fill: url(#linear-gradient);",
			"}",
			".cls-1,",
			".cls-2,",
			".cls-3,",
			".cls-4,",
			".cls-5,",
			".cls-6,",
			".cls-7,",
			".cls-8 {",
			"stroke-width: 0px;",
			"}",
			".cls-2 {",
			"fill: url(#radial-gradient);opacity: .48;",
			"}",
			".cls-3 {",
			"fill: #fff;",
			"opacity: .48;",
			"}",
			".cls-4 {",
			"fill: url(#linear-gradient-4);",
			"}",
			".cls-5 {",
			"fill: url(#linear-gradient-2);",
			"}",
			".cls-6 {",
			"fill: url(#linear-gradient-3);",
			"}",
			".cls-7 {",
			"fill: url(#linear-gradient-5);",
			"}",
			".cls-8 {",
			"fill: url(#linear-gradient-6);",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render1(
		string[6] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient" x1="133.48" y1="860.22" x2="275.26" y2="860.22" gradientUnits="userSpaceOnUse">',
			'<stop offset=".21" stop-color="#',
			colors[0],
			'" />',
			'<stop offset=".49" stop-color="#',
			colors[1],
			'" />',
			'<stop offset=".7" stop-color="#',
			colors[0],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-2" x1="922.46" x2="1064.24" xlink:href="#linear-gradient" />',
			'<linearGradient id="linear-gradient-3" x1="598.55" y1="875.83" x2="598.55" y2="998.44" gradientUnits="userSpaceOnUse">',
			'<stop offset=".02" stop-color="#',
			colors[2],
			'" />',
			'<stop offset=".81" stop-color="#',
			colors[3],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-4" x1="597.26" y1="53.23" x2="597.26" y2="183.08" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[3],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[4],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-5" x1="590.92" y1="494.96" x2="590.92" y2="952.7" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[3],
			'" />',
			'<stop offset=".84" stop-color="#',
			colors[4],
			'" />',
			"</linearGradient>",
			'<radialGradient id="radial-gradient" cx="596.37" cy="510.34" fx="596.37" fy="510.34" r="344.95" gradientTransform="translate(0 -90.14) scale(1 1.18)" gradientUnits="userSpaceOnUse">',
			'<stop offset=".39" stop-color="#fafefd" stop-opacity=".04" />',
			'<stop offset="1" stop-color="#',
			colors[5],
			'" />',
			"</radialGradient>"
		);

		return renderText;
	}

	function render2(
		string[6] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient-6" x1="182.98" y1="681.08" x2="987.4" y2="710.25" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[0],
			'" />',
			'<stop offset=".52" stop-color="#',
			colors[1],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[0],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient" x1="184.04" y1="401.22" x2="27.12" y2="806.6" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[2],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[3],
			'" />',
			"</linearGradient>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[6] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(),
			render1(colors),
			render2(colors),
			"</defs>",
			'<g id="Jet_',
			style.toString(),
			'">',
			'<polygon class="cls-1" points="204.37 941.11 133.48 850.22 204.37 779.33 275.26 850.22 204.37 941.11" />',
			'<polygon class="cls-5" points="993.35 941.11 922.46 850.22 993.35 779.33 1064.24 850.22 993.35 941.11" />',
			'<path class="cls-6" d="m793.07,953.91s-41.35,20-193.37,20-195.67-20-195.67-20l40-94.42h309.04l40,94.42Z" />',
			'<path class="cls-4" d="m695.95,179.02l-97.57-149.47-99.8,148.94c31.7-8.28,64.38-12.48,97.7-12.48s67.36,4.38,99.66,13Z" />',
			'<path class="cls-7" d="m943.27,563.88c-4.36,28.51-12.22,56.31-23.54,83.08-17.68,41.8-42.98,79.32-75.2,111.54-32.22,32.22-69.75,57.52-111.54,75.2-43.29,18.31-89.26,27.6-136.62,27.6s-93.33-9.28-136.62-27.6c-41.8-17.68-79.32-42.98-111.54-75.2-32.22-32.22-57.52-69.75-75.2-111.54-12.19-28.83-20.36-58.84-24.47-89.66L28.9,885.09h1124.04l-209.67-321.21Z" />',
			'<circle class="cls-2" cx="596.37" cy="510.34" r="344.27" />',
			'<path class="cls-8" d="m986.98,567.3l-40.11-60.56c-.63-.95-1.69-1.5-2.8-1.5-.01,0-.03,0-.04,0,.02,1.67.06,3.34.06,5.01,0,188.73-155.24,341.73-346.73,341.73s-346.73-153-346.73-341.73c0-4.13.1-8.24.25-12.34-.04,0-.08,0-.13,0-1.09,0-2.15.53-2.78,1.46l-41.24,60.66c-.45.67-.64,1.48-.54,2.27,4.63,34.17,13.89,67.61,27.52,99.38,19.88,46.33,48.33,87.92,84.56,123.63,36.23,35.71,78.43,63.75,125.44,83.34,48.69,20.3,100.38,30.59,153.64,30.59s104.95-10.29,153.64-30.59c47-19.59,89.21-47.64,125.44-83.34,36.23-35.71,64.68-77.3,84.56-123.63,12.67-29.53,21.58-60.51,26.48-92.09.12-.8-.06-1.62-.51-2.3Z" />',
			'<ellipse class="cls-3" cx="736.37" cy="283.03" rx="37.51" ry="55.07" transform="translate(37.9 649.76) rotate(-48.73)" />',
			'<ellipse class="cls-3" cx="838.11" cy="430.09" rx="34.25" ry="83.49" transform="translate(-103.43 400.06) rotate(-25.34)" />',
			"</g>"
		);

		return renderText;
	}
}
