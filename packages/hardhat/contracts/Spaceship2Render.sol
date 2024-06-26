//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./Spaceship2AuxRender.sol";

library Spaceship2Render {
	using Strings for uint256;

	function getColors(
		uint256 style
	) internal pure returns (string[12] memory) {
		if (style == 0) {
			string[12] memory colors = [
				"ff1d03",
				"ff9168",
				"ff1e03",
				"c96723",
				"ffb93b",
				"ffd487",
				"f27e8b",
				"b3b3b3",
				"e6e6e6",
				"808080",
				"333",
				"4d4d4d"
			];
			return colors;
		} else if (style == 1) {
			string[12] memory colors = [
				"6a3b85",
				"dd0aac",
				"623e83",
				"dd0aac",
				"fbcdb8",
				"ffd487",
				"c8a5db",
				"fbcdb8",
				"feede6",
				"fbcdb8",
				"412951",
				"392049"
			];
			return colors;
		} else if (style == 2) {
			string[12] memory colors = [
				"083330",
				"059599",
				"083330",
				"059ca0",
				"00dbdb",
				"059ca0",
				"9ae4da",
				"fbcdb8",
				"fefde8",
				"fbcdb8",
				"650034",
				"c8a5db"
			];
			return colors;
		} else if (style == 3) {
			string[12] memory colors = [
				"ff4803",
				"ffd13b",
				"ff4803",
				"1a1a1a",
				"666",
				"333",
				"ffe5ab",
				"b3b3b3",
				"e6e6e6",
				"808080",
				"333",
				"4d4d4d"
			];
			return colors;
		} else if (style == 4) {
			string[12] memory colors = [
				"056b68",
				"39b54a",
				"056b68",
				"056b68",
				"8cc63f",
				"8cc63f",
				"c5f9d0",
				"e5f9b5",
				"ffffea",
				"e5f9c2",
				"083330",
				"056b68"
			];
			return colors;
		} else {
			string[12] memory colors = [
				"999",
				"fff",
				"999",
				"000",
				"4d4d4d",
				"333",
				"f2f2f2",
				"333",
				"333",
				"4d4d4d",
				"333",
				"4d4d4d"
			];
			return colors;
		}
	}

	function renderStyle() internal pure returns (string memory) {
		string memory renderText = string.concat(
			"<style>",
			".cls-1,",
			".cls-2,",
			".cls-3,",
			".cls-4 {",
			"fill: none;",
			"}",
			".cls-1,",
			".cls-5,",
			".cls-6,",
			".cls-7,",
			".cls-8,",
			".cls-9,",
			".cls-10,",
			".cls-11,",
			".cls-12,",
			".cls-13,",
			".cls-14,",
			".cls-15,",
			".cls-16,",
			".cls-17,",
			".cls-18,",
			".cls-19,",
			".cls-20,",
			".cls-21,",
			".cls-22,",
			".cls-23,",
			".cls-24,",
			".cls-25,",
			".cls-26,",
			".cls-27,",
			".cls-28,",
			".cls-29,",
			".cls-30,",
			".cls-31,",
			".cls-32,",
			".cls-33,",
			".cls-34,",
			".cls-35,",
			".cls-36,",
			".cls-37,",
			".cls-38,",
			".cls-39 {",
			"stroke-width: 0px;",
			"}",
			".cls-2 {",
			"stroke: #f2f2f2;",
			"}",
			".cls-2,",
			".cls-3 {",
			"stroke-width: 30px;",
			"}",
			".cls-2,",
			".cls-3,",
			".cls-4 {",
			"stroke-miterlimit: 10;",
			"}",
			".cls-3 {",
			"stroke: #b3b3b3;",
			"}",
			".cls-5 {",
			"fill: url(#linear-gradient);",
			"}",
			".cls-6 {",
			"fill: url(#radial-gradient);opacity: .48;",
			"}",
			".cls-7 {",
			"fill: url(#linear-gradient-33);",
			"}",
			".cls-8 {",
			"fill: url(#linear-gradient-29);",
			"}",
			".cls-9 {",
			"fill: url(#linear-gradient-32);",
			"}",
			".cls-10 {",
			"fill: url(#linear-gradient-30);",
			"}",
			".cls-11 {",
			"fill: url(#linear-gradient-31);",
			"}",
			".cls-12 {",
			"fill: url(#linear-gradient-34);",
			"}",
			".cls-13 {",
			"fill: url(#linear-gradient-28);",
			"}",
			".cls-14 {",
			"fill: url(#linear-gradient-25);",
			"}",
			".cls-15 {",
			"fill: url(#linear-gradient-11);",
			"}",
			".cls-16 {",
			"fill: url(#linear-gradient-12);",
			"}",
			".cls-17 {",
			"fill: url(#linear-gradient-13);",
			"}",
			".cls-18 {",
			"fill: url(#linear-gradient-10);",
			"}",
			".cls-19 {",
			"fill: url(#linear-gradient-17);",
			"}",
			".cls-20 {",
			"fill: url(#linear-gradient-16);",
			"}",
			".cls-21 {",
			"fill: url(#linear-gradient-19);",
			"}",
			".cls-22 {",
			"fill: url(#linear-gradient-15);",
			"}",
			".cls-23 {",
			"fill: url(#linear-gradient-23);",
			"}",
			".cls-24 {",
			"fill: url(#linear-gradient-21);",
			"}",
			".cls-25 {",
			"fill: url(#linear-gradient-18);",
			"}",
			".cls-26 {",
			"fill: url(#linear-gradient-14);",
			"}",
			".cls-27 {",
			"fill: url(#linear-gradient-22);",
			"}",
			".cls-28 {",
			"fill: url(#linear-gradient-20);",
			"}",
			".cls-29 {",
			"fill: url(#linear-gradient-27);",
			"}",
			".cls-30 {",
			"fill: url(#linear-gradient-24);",
			"}",
			".cls-31 {",
			"fill: url(#linear-gradient-26);",
			"}",
			".cls-4 {",
			"stroke: #666;",
			"stroke-width: 29.26px;",
			"}",
			".cls-32 {",
			"fill: url(#linear-gradient-4);",
			"}",
			".cls-33 {",
			"fill: url(#linear-gradient-2);",
			"}",
			".cls-34 {",
			"fill: url(#linear-gradient-3);",
			"}",
			".cls-35 {",
			"fill: url(#linear-gradient-8);",
			"}",
			".cls-36 {",
			"fill: url(#linear-gradient-9);",
			"}",
			".cls-37 {",
			"fill: url(#linear-gradient-7);",
			"}",
			".cls-38 {",
			"fill: url(#linear-gradient-5);",
			"}",
			".cls-39 {",
			"fill: url(#linear-gradient-6);",
			"}",
			"</style>"
		);

		return renderText;
	}

	function render(uint256 style) public pure returns (string memory) {
		string[12] memory colors = getColors(style);
		string memory renderText = string.concat(
			"<defs>",
			renderStyle(),
			Spaceship2AuxRender.render1(colors),
			Spaceship2AuxRender.render2(colors),
			Spaceship2AuxRender.render3(),
			"</defs>",
			'<g id="Capsule_',
			style.toString(),
			'">',
			'<rect class="cls-5" x="163.57" y="921.11" width="183.53" height="11.12" transform="translate(-705.82 936.17) rotate(-75.16)" />',
			'<ellipse class="cls-33" cx="231.7" cy="1016.22" rx="10.78" ry="56.62" transform="translate(-809.96 979.86) rotate(-75.16)" />',
			'<rect class="cls-34" x="936.35" y="834.91" width="11.12" height="183.53" transform="translate(-205.91 272.14) rotate(-14.84)" />',
			'<ellipse class="cls-32" cx="965.55" cy="1016.22" rx="56.62" ry="10.78" transform="translate(-228.11 281.26) rotate(-14.84)" />',
			'<path class="cls-38" d="m793.15,987.14s-41.35,20-193.37,20-195.67-20-195.67-20l40-94.42h309.04l40,94.42Z" />',
			'<path class="cls-39" d="m1098.72,810.85l-139.84-667.88c-7.19-40.05-42.03-69.2-82.72-69.2H323.08c-40.69,0-75.53,29.15-82.72,69.2L100.52,810.85c-9.25,51.53,30.37,98.88,82.72,98.88h832.77c52.35,0,91.97-47.35,82.72-98.88Zm-239.35-50.54H339.86c-32.66,0-57.37-29.54-51.6-61.69l74.76-416.65c4.48-24.98,26.22-43.17,51.6-43.17h369.99c25.38,0,47.12,18.18,51.6,43.17l74.76,416.65c5.77,32.15-18.94,61.69-51.6,61.69Z" />',
			'<path class="cls-37" d="m1098.72,810.85l-9.34-49.51c9.07,50.58-49.8,77.05-101.18,77.05H210.88c-51.38,0-110.26-26.47-101.18-77.05l-9.18,49.51c-9.25,51.53,30.36,98.88,82.72,98.88h832.77c52.35,0,91.97-47.35,82.72-98.88Z" />',
			'<path class="cls-35" d="m394.84,171.3h413.77c32.26,0,129.79-18.72,144.04-46.91-30.99-79.08-178.61-92.63-354.77-90.94-189.32,1.82-328.17,15.24-352.48,90.94,14.25,28.2,117.18,46.91,149.44,46.91Z" />',
			'<path class="cls-1" d="m836.22,278.71c-4.48-24.98-26.22-43.17-51.6-43.17h-369.99c-25.38,0-47.12,18.18-51.6,43.17l-74.76,416.65c-5.77,32.15,18.94,61.69,51.6,61.69h519.51c32.66,0,57.37-29.54,51.6-61.69l-74.76-416.65Z" />',
			'<path class="cls-6" d="m784.62,238.81h-369.99c-25.38,0-47.12,18.18-51.6,43.17l-74.76,416.65c-5.77,32.15,18.94,61.69,51.6,61.69h519.51c32.66,0,57.37-29.54,51.6-61.69l-74.76-416.65c-4.48-24.98-26.22-43.17-51.6-43.17Z" />',
			'<path class="cls-4" d="m776.68,250.06h-354.13c-24.3,0-45.1,18.08-49.39,42.91l-72.44,419.3c-5.06,29.29,16.62,56.21,45.28,56.21h502.25c31.26,0,54.91-29.37,49.39-61.32l-71.56-414.19c-4.29-24.84-25.1-42.91-49.39-42.91Z" />',
			'<path class="cls-3" d="m288.26,707.44c-5.77,32.15,18.94,61.69,51.6,61.69h519.51c32.66,0,57.37-29.54,51.6-61.69" />',
			'<path class="cls-2" d="m784.62,238.81h-369.99c-25.38,0-47.12,18.18-51.6,43.17l-74.76,416.65c-5.77,32.15,18.94,61.69,51.6,61.69h519.51c32.66,0,57.37-29.54,51.6-61.69l-74.76-416.65c-4.48-24.98-26.22-43.17-51.6-43.17Z" />',
			'<path class="cls-36" d="m149.02,552.63h0c-4.43-.8-8.68,2.08-9.58,6.49l-52.44,254.54c-11.24,54.56,29.6,106.01,85.29,107.44l35.12.9c4.52.12,8.29-3.41,8.49-7.92l11.06-249.34c9.4-52.26-25.67-102.71-77.93-112.11Z" />',
			'<rect class="cls-18" x="118.05" y="601.53" width="79.03" height="22.34" rx="11.17" ry="11.17" transform="translate(15.76 -3.84) rotate(1.47)" />',
			'<rect class="cls-15" x="125.65" y="572.64" width="58.19" height="22.34" rx="11.17" ry="11.17" transform="translate(15.02 -3.78) rotate(1.47)" />',
			'<rect class="cls-16" x="110.32" y="630.42" width="101.03" height="22.34" rx="11.17" ry="11.17" transform="translate(16.5 -3.91) rotate(1.47)" />',
			'<rect class="cls-17" x="105.23" y="659.2" width="108.28" height="22.34" rx="11.17" ry="11.17" transform="translate(17.24 -3.87) rotate(1.47)" />',
			'<rect class="cls-26" x="100.18" y="687.94" width="112.35" height="22.34" rx="11.17" ry="11.17" transform="translate(17.98 -3.78) rotate(1.47)" />',
			'<rect class="cls-22" x="92.83" y="716.64" width="118.69" height="22.34" rx="11.17" ry="11.17" transform="translate(18.71 -3.66) rotate(1.47)" />',
			'<rect class="cls-20" x="87.86" y="745.39" width="123.65" height="22.34" rx="11.17" ry="11.17" transform="translate(19.45 -3.59) rotate(1.47)" />',
			'<rect class="cls-19" x="82.03" y="774.1" width="127.05" height="22.34" rx="11.17" ry="11.17" transform="translate(20.18 -3.47) rotate(1.47)" />',
			'<rect class="cls-25" x="76.36" y="802.83" width="131.83" height="22.34" rx="11.17" ry="11.17" transform="translate(20.92 -3.38) rotate(1.47)" />',
			'<rect class="cls-21" x="74.14" y="831.59" width="132.51" height="22.34" rx="10.95" ry="10.95" transform="translate(21.65 -3.32) rotate(1.47)" />',
			'<rect class="cls-28" x="80.7" y="860.47" width="124.3" height="22.34" rx="10.96" ry="10.96" transform="translate(22.4 -3.38) rotate(1.47)" />',
			'<rect class="cls-24" x="97.34" y="889.46" width="105.03" height="22.34" rx="10.93" ry="10.93" transform="translate(23.14 -3.55) rotate(1.47)" />',
			'<path class="cls-27" d="m1049.53,552.63h0c4.43-.8,8.68,2.08,9.58,6.49l52.44,254.54c11.24,54.56-29.6,106.01-85.29,107.44l-35.12.9c-4.52.12-8.29-3.41-8.49-7.92l-11.06-249.34c-9.4-52.26,25.67-102.71,77.93-112.11Z" />',
			'<rect class="cls-23" x="1001.46" y="601.53" width="79.03" height="22.34" rx="11.17" ry="11.17" transform="translate(2097.33 1198.49) rotate(178.53)" />',
			'<rect class="cls-30" x="1014.71" y="572.64" width="58.19" height="22.34" rx="11.17" ry="11.17" transform="translate(2102.23 1140.66) rotate(178.53)" />',
			'<rect class="cls-14" x="987.2" y="630.42" width="101.03" height="22.34" rx="11.17" ry="11.17" transform="translate(2091.54 1256.36) rotate(178.53)" />',
			'<rect class="cls-31" x="985.04" y="659.2" width="108.28" height="22.34" rx="11.17" ry="11.17" transform="translate(2095.2 1313.87) rotate(178.53)" />',
			'<rect class="cls-29" x="986.02" y="687.94" width="112.35" height="22.34" rx="11.17" ry="11.17" transform="translate(2101.97 1371.26) rotate(178.53)" />',
			'<rect class="cls-13" x="987.03" y="716.64" width="118.69" height="22.34" rx="11.17" ry="11.17" transform="translate(2111.06 1428.55) rotate(178.53)" />',
			'<rect class="cls-8" x="987.04" y="745.39" width="123.65" height="22.34" rx="11.17" ry="11.17" transform="translate(2116.79 1485.98) rotate(178.53)" />',
			'<rect class="cls-10" x="989.47" y="774.1" width="127.05" height="22.34" rx="11.17" ry="11.17" transform="translate(2125.78 1543.28) rotate(178.53)" />',
			'<rect class="cls-11" x="990.35" y="802.83" width="131.83" height="22.34" rx="11.17" ry="11.17" transform="translate(2133.06 1600.64) rotate(178.53)" />',
			'<rect class="cls-9" x="991.9" y="831.59" width="132.51" height="22.34" rx="10.95" ry="10.95" transform="translate(2137.57 1658.12) rotate(178.53)" />',
			'<rect class="cls-7" x="993.55" y="860.47" width="124.3" height="22.34" rx="10.96" ry="10.96" transform="translate(2133.4 1715.92) rotate(178.53)" />',
			'<rect class="cls-12" x="996.18" y="889.46" width="105.03" height="22.34" rx="10.93" ry="10.93" transform="translate(2120.14 1774.08) rotate(178.53)" />',
			"</g>"
		);

		return renderText;
	}
}
