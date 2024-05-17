//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

library Spaceship2AuxRender {
	function render1(
		string[12] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient" x1="268.34" y1="1033.32" x2="302.87" y2="996.97" gradientTransform="translate(706.72 8.59) rotate(45)" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#1a1a1a" />',
			'<stop offset="1" stop-color="#333" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-2" x1="382.82" y1="916.58" x2="430.99" y2="866.6" gradientTransform="translate(355.51 98.01) rotate(70.23) scale(.75 .48) skewX(37.64)" xlink:href="#linear-gradient" />',
			'<linearGradient id="linear-gradient-3" x1="-226.58" y1="745.77" x2="-192.05" y2="709.41" gradientTransform="translate(1306.69 328.7) rotate(-135) scale(1 -1)" xlink:href="#linear-gradient" />',
			'<linearGradient id="linear-gradient-4" x1="-296.83" y1="813.76" x2="-248.67" y2="763.78" gradientTransform="translate(1330.46 745.78) rotate(-160.23) scale(.75 -.48) skewX(37.64)" xlink:href="#linear-gradient" />',
			'<linearGradient id="linear-gradient-5" x1="598.62" y1="909.07" x2="598.62" y2="1031.67" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#1a1a1a" />',
			'<stop offset=".03" stop-color="#1c1c1c" />',
			'<stop offset=".22" stop-color="#292929" />',
			'<stop offset=".47" stop-color="#303030" />',
			'<stop offset="1" stop-color="#333" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-6" x1="99.17" y1="491.75" x2="1100.07" y2="491.75" gradientUnits="userSpaceOnUse">',
			'<stop offset=".05" stop-color="#',
			colors[0],
			'" />',
			'<stop offset=".56" stop-color="#',
			colors[1],
			'" />',
			'<stop offset=".94" stop-color="#',
			colors[2],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-7" x1="599.62" y1="915.6" x2="599.62" y2="838.76" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[3],
			'" />',
			'<stop offset=".83" stop-color="#',
			colors[4],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-8" x1="599.03" y1="146.07" x2="599.03" y2="41.42" gradientUnits="userSpaceOnUse">',
			'<stop offset=".17" stop-color="#',
			colors[4],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[5],
			'" />',
			"</linearGradient>"
		);

		return renderText;
	}

	function render2(
		string[12] memory colors
	) public pure returns (string memory) {
		string memory renderText = string.concat(
			'<radialGradient id="radial-gradient" cx="599.62" cy="499.56" fx="599.62" fy="499.56" r="425.41" gradientUnits="userSpaceOnUse">',
			'<stop offset=".38" stop-color="#fafefd" stop-opacity=".04" />',
			'<stop offset=".9" stop-color="#',
			colors[6],
			'" />',
			"</radialGradient>",
			'<linearGradient id="linear-gradient-9" x1="178.08" y1="559.34" x2="149.75" y2="924.95" gradientTransform="translate(18.94 -3.64) rotate(1.47)" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[7],
			'" />',
			'<stop offset=".5" stop-color="#',
			colors[8],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[9],
			'" />',
			"</linearGradient>",
			'<linearGradient id="linear-gradient-10" x1="154.39" y1="624.64" x2="154.39" y2="602.18" gradientTransform="translate(3.18 .11)" gradientUnits="userSpaceOnUse">',
			'<stop offset="0" stop-color="#',
			colors[10],
			'" />',
			'<stop offset="1" stop-color="#',
			colors[11],
			'" />',
			"</linearGradient>"
		);

		return renderText;
	}

	function render3() public pure returns (string memory) {
		string memory renderText = string.concat(
			'<linearGradient id="linear-gradient-11" x1="150.83" y1="596.31" x2="150.83" y2="573.11" gradientTransform="translate(3.92 .03)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-12" x1="158.4" y1="652.43" x2="158.4" y2="630.2" gradientTransform="translate(2.44 .21)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-13" x1="157.67" y1="682.4" x2="157.67" y2="659.12" gradientTransform="translate(1.7 .18)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-14" x1="155.39" y1="711.82" x2="155.39" y2="688.53" gradientTransform="translate(.96 .11)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-15" x1="151.95" y1="739.61" x2="151.95" y2="716.02" gradientTransform="translate(.23 .01)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-16" x1="150.2" y1="768.49" x2="150.2" y2="745.83" gradientTransform="translate(-.51 -.04)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-17" x1="146.8" y1="796.82" x2="146.8" y2="774.07" gradientTransform="translate(-1.25 -.14)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-18" x1="144.27" y1="826.25" x2="144.27" y2="802.95" gradientTransform="translate(-1.99 -.21)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-19" x1="143.12" y1="855.12" x2="143.12" y2="832.14" gradientTransform="translate(-2.73 -.25)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-20" x1="146.32" y1="883.46" x2="146.32" y2="861.22" gradientTransform="translate(-3.47 -.18)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-21" x1="154.06" y1="913.43" x2="154.06" y2="890.33" gradientTransform="translate(-4.21 .01)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-22" x1="841.67" y1="542.32" x2="813.33" y2="907.93" gradientTransform="translate(1843.42 -3.64) rotate(178.53) scale(1 -1)" xlink:href="#linear-gradient-9" />',
			'<linearGradient id="linear-gradient-23" x1="817.98" y1="607.62" x2="817.98" y2="585.16" gradientTransform="translate(223 1208.25) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-24" x1="814.41" y1="579.29" x2="814.41" y2="556.09" gradientTransform="translate(229.39 1150.56) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-25" x1="821.98" y1="635.41" x2="821.98" y2="613.18" gradientTransform="translate(215.74 1265.96) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-26" x1="821.25" y1="665.38" x2="821.25" y2="642.1" gradientTransform="translate(217.92 1323.54) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-27" x1="818.98" y1="694.8" x2="818.98" y2="671.5" gradientTransform="translate(223.22 1381.08) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-28" x1="815.54" y1="722.59" x2="815.54" y2="699" gradientTransform="translate(230.83 1438.59) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-29" x1="813.78" y1="751.47" x2="813.78" y2="728.81" gradientTransform="translate(235.09 1496.14) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-30" x1="810.39" y1="779.8" x2="810.39" y2="757.05" gradientTransform="translate(242.61 1553.65) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-31" x1="807.85" y1="809.23" x2="807.85" y2="785.93" gradientTransform="translate(248.42 1611.19) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-32" x1="806.71" y1="838.1" x2="806.71" y2="815.12" gradientTransform="translate(251.45 1668.76) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-33" x1="809.9" y1="866.44" x2="809.9" y2="844.2" gradientTransform="translate(245.8 1726.44) scale(1 -1)" xlink:href="#linear-gradient-10" />',
			'<linearGradient id="linear-gradient-34" x1="817.64" y1="896.41" x2="817.64" y2="873.31" gradientTransform="translate(231.05 1784.24) scale(1 -1)" xlink:href="#linear-gradient-10" />'
		);

		return renderText;
	}
}
