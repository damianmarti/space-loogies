//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

library Spaceship1Render {
	using Strings for uint256;

	function getColors(uint256 style) internal pure returns (string[7] memory) {
		if (style == 0) {
			string[7] memory colors = [
				"b3b3b3",
				"fff",
				"1a1a1a",
				"333",
				"fff",
				"999",
				"c2efe9"
			];
			return colors;
		} else if (style == 1) {
			string[7] memory colors = [
				"9ae4da",
				"9ae4da",
				"083330",
				"056b68",
				"00dbdb",
				"059ca0",
				"9ae4da"
			];
			return colors;
		} else if (style == 2) {
			string[7] memory colors = [
				"f27e8b",
				"fcded1",
				"395175",
				"dd0aac",
				"fbcdb8",
				"f27e8b",
				"c8a5db"
			];
			return colors;
		} else if (style == 3) {
			string[7] memory colors = [
				"ffb93b",
				"ffeec8",
				"ff4803",
				"ffb93b",
				"666",
				"333",
				"ffe5ab"
			];
			return colors;
		} else if (style == 4) {
			string[7] memory colors = [
				"39b54a",
				"d9fbe0",
				"056b68",
				"39b54a",
				"e5f97b",
				"8cc63f",
				"c5f9d0"
			];
			return colors;
		} else {
			string[7] memory colors = [
				"FF4803",
				"FFB93B",
				"412951",
				"951005",
				"FFB93B",
				"FF4803",
				"F27E8B"
			];
			return colors;
		}
	}

	function renderStyle(
		string[7] memory colors
	) internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".cls-1, .cls-2 {",
			"stroke: #",
			colors[0],
			";",
			"stroke-width: 1.11px;",
			"}",
			".cls-1,",
			".cls-2 {",
			"fill: none;",
			"stroke-miterlimit: 10;",
			"}",
			".cls-3 {",
			"fill: url(#linear-gradient);",
			"}",
			".cls-3,",
			".cls-4,",
			".cls-5,",
			".cls-6,",
			".cls-7,",
			".cls-8,",
			".cls-9,",
			".cls-10,",
			".cls-11,",
			".cls-12,",
			".cls-13 {",
			"stroke-width: 0px;",
			"}",
			".cls-4 {",
			"fill: url(#radial-gradient);",
			"}",
			".cls-5 {",
			"fill: url(#radial-gradient-2);",
			"}",
			".cls-6 {",
			"fill: url(#radial-gradient-3);",
			"}",
			".cls-7 {",
			"fill: url(#radial-gradient-4);",
			"}",
			".cls-8 {",
			"opacity: .48;",
			"}",
			".cls-8 {",
			"fill: #fff;",
			"}",
			".cls-14 {",
			"opacity: .69;",
			"}",
			".cls-9 {",
			"fill: url(#linear-gradient-4);",
			"}",
			".cls-10 {",
			"fill: url(#linear-gradient-2);",
			"}",
			".cls-11 {",
			"fill: url(#linear-gradient-3);",
			"}",
			".cls-12 {",
			"fill: url(#linear-gradient-5);",
			"}",
			".cls-2 {",
			"stroke-width: 8.9px;",
			"}",
			".cls-13 {",
			"fill: #",
			colors[1],
			";",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render1(
		string[7] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient" x1="331.19" y1="1057.22" x2="365.72" y2="1020.86" gradientTransform="translate(816.77 12.81) rotate(45)" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[2],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[3],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-2" x1="865.39" y1="1048.34" x2="782.68" y2="967.45" gradientTransform="translate(938.28 -280.74) rotate(45)" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[2],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[3],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-3" x1="292.15" y1="1089.6" x2="340.32" y2="1039.62" gradientTransform="translate(845.92 89.38) rotate(45)" xlink:href="#linear-gradient" />',
			'<linearGradient id="linear-gradient-4" x1="907.46" y1="1092.42" x2="861.11" y2="1043.34" gradientTransform="translate(1012.07 -311.73) rotate(45)" gradientUnits="userSpaceOnUse">',
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

	function render2(
		string[7] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient-5" x1="595.64" y1="1133.66" x2="598.06" y2="927.66" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[3],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[2],
			'" />',
			"</linearGradient>",
			'<radialGradient id="radial-gradient" cx="603.33" cy="705.45" fx="603.33" fy="705.45" r="763.86" gradientTransform="translate(1.59 497.35) rotate(.44) scale(1 .29)" gradientUnits="userSpaceOnUse">',
			'<stop offset=".54" stop-color="#',
			colors[4],
			'" />',
			'<stop offset=".83" stop-color="#',
			colors[5],
			'" />',
			"</radialGradient>",
			'<radialGradient id="radial-gradient-2" cx="598.7" cy="482.71" fx="598.7" fy="482.71" r="268.37" gradientTransform="translate(0 -85.26) scale(1 1.18)" gradientUnits="userSpaceOnUse">',
			'<stop offset=".39" stop-color="#fafefd" stop-opacity=".04" />',
			'<stop offset="1" stop-color="#',
			colors[6],
			'" />',
			"</radialGradient>",
			'<radialGradient id="radial-gradient-3" cx="598.77" cy="71.61" fx="598.77" fy="71.61" r="72.73" gradientUnits="userSpaceOnUse">',
			'<stop offset=".15" stop-color="#',
			colors[4],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[5],
			'" />',
			"</radialGradient>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[7] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(colors),
			render1(colors),
			render2(colors),
			'<radialGradient id="radial-gradient-4" cx="598.7" cy="216.68" fx="598.7" fy="216.68" r="112.62" gradientTransform="translate(1.35 95.33) rotate(.66) scale(1 .53)" gradientUnits="userSpaceOnUse">',
			'<stop offset=".15" stop-color="#',
			colors[4],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[5],
			'" />',
			"</radialGradient>",
			"</defs>",
			'<g id="UFO_',
			style.toString(),
			'">',
			'<rect class="cls-3" x="301.16" y="986.67" width="183.53" height="11.12" transform="translate(-586.56 568.52) rotate(-45)" />',
			'<rect class="cls-10" x="802.46" y="900.47" width="11.12" height="183.53" transform="translate(-464.95 861.98) rotate(-45)" />',
			'<ellipse class="cls-11" cx="315.07" cy="1065.81" rx="29.99" ry="56.62" transform="translate(-661.36 534.96) rotate(-45)" />',
			'<ellipse class="cls-9" cx="882.33" cy="1065.81" rx="56.62" ry="29.99" transform="translate(-495.21 936.07) rotate(-45)" />',
			'<path class="cls-12" d="m346.52,872.7c22.86,77.08,127.15,135.3,252.38,135.3s228.32-57.54,251.99-133.95c-69.86,5.18-153.56,8.19-243.56,8.19-97.53,0-187.67-3.54-260.81-9.54Z" />',
			'<path class="cls-4" d="m1114.45,729.13c-18.08-44.32-106.9-86.71-242.66-111.6.04,2.7.07,5.4.07,8.11,0,24.58-1.86,21.08-5.39,44.28-52.37,46.42-169.48,73.69-265.03,73.69-103.56,0-227.21-32.72-270.49-76.6-3.24-22.3-4.96-17.82-4.96-41.37,0-2.6.03-5.19.07-7.77-134.78,24.99-222.91,67.29-241.47,111.26-49.94,118.32,190.86,187.16,514.93,191.02,304.82,3.64,558.75-83.61,514.93-191.02Z" />',
			'<g class="cls-14">',
			'<path class="cls-5" d="m863.46,482.13c-35.4-149.09-140.54-257.22-264.76-257.22s-230.7,109.53-265.42,260.1c-7.85,34.03-12.08,70.15-12.08,107.58,0,23.95,1.75,47.35,5.05,70.02,44.01,44.62,169.73,77.88,275.02,77.88,97.15,0,216.23-27.72,269.47-74.92,3.59-23.59,5.48-47.99,5.48-72.98,0-38.49-4.47-75.6-12.75-110.47Z" />',
			"</g>",
			'<path class="cls-13" d="m598.7,230.27c122.17,0,225.58,106.35,260.4,252.98,8.14,34.3,12.54,70.79,12.54,108.65,0,24.58-1.86,48.58-5.39,71.78-52.37,46.42-169.48,73.69-265.04,73.69-103.56,0-227.21-32.72-270.49-76.6-3.24-22.3-4.96-45.32-4.96-68.87,0-36.82,4.17-72.34,11.88-105.81,34.15-148.1,138.1-255.82,261.05-255.82m0-7.78c-31.19,0-61.83,6.67-91.05,19.83-28.14,12.67-54.47,31.11-78.27,54.81-23.42,23.33-43.84,51.2-60.7,82.85-17.04,31.99-30.03,67.1-38.62,104.36-8.02,34.77-12.08,70.95-12.08,107.56,0,23.43,1.7,46.98,5.05,69.99l.37,2.53,1.79,1.82c21.53,21.83,62.76,41.99,116.1,56.79,51.45,14.27,108.24,22.13,159.93,22.13s102.63-6.99,150.7-19.69c66.38-17.54,101.62-40.11,119.5-55.95l2.11-1.87.42-2.79c3.63-23.9,5.47-48.44,5.47-72.95,0-37.65-4.29-74.81-12.75-110.45-8.76-36.9-21.86-71.65-38.92-103.29-16.89-31.31-37.29-58.88-60.63-81.93-23.72-23.43-49.93-41.65-77.92-54.16-29.06-13-59.51-19.59-90.51-19.59h0Z" />',
			'<line class="cls-2" x1="598.7" y1="127.04" x2="598.7" y2="239.74" />',
			'<circle class="cls-6" cx="598.7" cy="106.14" r="29.99" />',
			'<ellipse class="cls-8" cx="686.77" cy="330.37" rx="37.51" ry="45.01" transform="translate(-32.46 582.39) rotate(-45)" />',
			'<ellipse class="cls-8" cx="768.96" cy="449.85" rx="29.82" ry="69.34" transform="translate(-118.54 372.37) rotate(-25.34)" />',
			'<path class="cls-7" d="m503.29,244.75s8.99,27.71,93.3,27.71,97.53-27.71,97.53-27.71c-26.66-23.7-59.67-37.73-95.42-37.73s-68.76,14.03-95.41,37.73Z" />',
			'<path class="cls-1" d="m500.95,734.71c-4,6.81-59.07,49.73-49.98,178.78" />',
			'<path class="cls-1" d="m367.46,693.84s-238.56,56.06-193.12,163.3" />',
			'<path class="cls-1" d="m322.23,642.62s-76.82.03-144.08,16.39" />',
			'<path class="cls-1" d="m712.37,732.53c4.26,5.17,58.82,51.9,49.73,180.96" />',
			'<path class="cls-1" d="m824.61,697.11s232.31,52.79,186.87,160.03" />',
			'<path class="cls-1" d="m876.92,643.17s76.39-.51,143.64,15.85" />',
			"</g>"
		);

		return renderText;
	}
}
