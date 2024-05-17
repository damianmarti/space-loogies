//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Propulsion3Render {
	using Strings for uint256;

	function getColors(uint256 style) internal pure returns (string[3] memory) {
		if (style == 0) {
			string[3] memory colors = ["faffff", "beffff", "00FFFF"];
			return colors;
		} else if (style == 1) {
			string[3] memory colors = ["fefefc", "f8fddc", "e5f97b"];
			return colors;
		} else if (style == 2) {
			string[3] memory colors = ["fefcfd", "fbdcdf", "f27e8b"];
			return colors;
		} else if (style == 3) {
			string[3] memory colors = ["fffdfb", "ffedcd", "ffb93b"];
			return colors;
		} else {
			string[3] memory colors = ["808080", "808080", "808080"];
			return colors;
		}
	}

	function renderStyle() internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".pcls-1 {",
			"fill: url(#radial-gradient);",
			"}",
			".pcls-1,",
			".pcls-2,",
			".pcls-3,",
			".pcls-4 {",
			"stroke-width: 0px;",
			"}",
			".pcls-2 {",
			"fill: url(#radial-gradient-2);",
			"}",
			".pcls-3 {",
			"fill: url(#radial-gradient-3);",
			"}",
			".pcls-4 {",
			"fill: url(#radial-gradient-4);",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[3] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(),
			'<radialGradient id="radial-gradient" cx="604.07" cy="1106.4" fx="604.07" fy="1106.4" r="242.01" gradientTransform="translate(0 956.89) scale(1 .14)" gradientUnits="userSpaceOnUse">',
			'<stop offset=".56" stop-color="#fff" stop-opacity="0" />',
			'<stop offset=".6" stop-color="#',
			colors[0],
			'" stop-opacity=".02" />',
			'<stop offset=".72" stop-color="#',
			colors[1],
			'" stop-opacity=".25" />',
			'<stop offset=".88" stop-color="#',
			colors[2],
			'" />',
			"</radialGradient>",
			'<radialGradient id="radial-gradient-2" cx="605.56" cy="1175.21" fx="605.56" fy="1175.21" r="320.42" gradientTransform="translate(0 1031.8) scale(1 .14)" xlink:href="#radial-gradient" />',
			'<radialGradient id="radial-gradient-3" cx="607.3" cy="1262.25" fx="607.3" fy="1262.25" r="411.21" gradientTransform="translate(0 1126.56) scale(1 .14)" xlink:href="#radial-gradient" />',
			'<radialGradient id="radial-gradient-4" cx="609.56" cy="1370.79" fx="609.56" fy="1370.79" r="529.66" gradientTransform="translate(0 1244.71) scale(1 .14)" xlink:href="#radial-gradient" />',
			"</defs>",
			'<g id="Waves_',
			style.toString(),
			'">',
			'<ellipse class="pcls-1" cx="599.44" cy="1116.33" rx="218.77" ry="28.79" />',
			'<ellipse class="pcls-2" cx="599.44" cy="1202.63" rx="289.65" ry="38.12" />',
			'<ellipse class="pcls-3" cx="599.44" cy="1311.6" rx="371.73" ry="48.92" />',
			'<ellipse class="pcls-4" cx="599.44" cy="1447.6" rx="478.81" ry="63.01" />',
			"</g>"
		);

		return renderText;
	}
}
