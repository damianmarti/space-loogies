//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Propulsion1Render {
	using Strings for uint256;

	function getColors(uint256 style) internal pure returns (string[3] memory) {
		if (style == 0) {
			string[3] memory colors = ["ffda3e", "ff4803", "f7931e"];
			return colors;
		} else if (style == 1) {
			string[3] memory colors = ["39b54a", "8ae200", "ebff57"];
			return colors;
		} else if (style == 2) {
			string[3] memory colors = ["f8bbff", "9e009e", "f200c4"];
			return colors;
		} else if (style == 3) {
			string[3] memory colors = ["c2fffd", "00b6c4", "00eade"];
			return colors;
		} else {
			string[3] memory colors = ["ffda3e", "ff4803", "f7931e"];
			return colors;
		}
	}

	function renderStyle(
		string[3] memory colors
	) internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".pcls-1 {",
			"fill: #",
			colors[0],
			";",
			"}",
			".pcls-1,",
			".pcls-2,",
			".pcls-3 {",
			"stroke-width: 0px;",
			"}",
			".pcls-2 {",
			"fill: #",
			colors[1],
			";",
			"}",
			".pcls-3 {",
			"fill: #",
			colors[2],
			";",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[3] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(colors),
			"</defs>",
			'<g id="Jet_',
			style.toString(),
			'">',
			'<path class="pcls-1" d="m729.26,1201.33c0,132.19-129.14,313.93-129.14,313.93,0,0-129.14-181.75-129.14-313.93s83.63-164.76,129.14-164.76c43.05,0,129.14,32.57,129.14,164.76Z" />',
			'<path class="pcls-2" d="m697.28,1168.14c0,99.46-97.16,236.2-97.16,236.2,0,0-97.16-136.74-97.16-236.2s62.92-123.96,97.16-123.96c32.39,0,97.16,24.51,97.16,123.96Z" />',
			'<path class="pcls-3" d="m671.38,1143.75c0,72.94-71.26,173.23-71.26,173.23,0,0-71.26-100.29-71.26-173.23s46.15-90.91,71.26-90.91c23.75,0,71.26,17.97,71.26,90.91Z" />'
			"</g>"
		);

		return renderText;
	}
}
