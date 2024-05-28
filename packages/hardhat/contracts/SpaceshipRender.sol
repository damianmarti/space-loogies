//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";

import "./Spaceship1Render.sol";
import "./Spaceship2Render.sol";
import "./Spaceship3Render.sol";
import "./Spaceship4Render.sol";
import "./Spaceship5Render.sol";
import "./Propulsion1Render.sol";
import "./Propulsion2Render.sol";
import "./Propulsion3Render.sol";

abstract contract NFTContract {
	function renderTokenById(
		uint256 id
	) external view virtual returns (string memory);

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) external virtual;
}

library SpaceshipRender {
	using Strings for uint256;

	function renderSpaceship(
		uint256 spaceshipType,
		uint256 spaceshipStyle
	) public pure returns (string memory) {
		if (spaceshipType == 0) {
			return Spaceship1Render.render(spaceshipStyle);
		}

		if (spaceshipType == 1) {
			return Spaceship2Render.render(spaceshipStyle);
		}

		if (spaceshipType == 2) {
			return Spaceship3Render.render(spaceshipStyle);
		}

		if (spaceshipType == 3) {
			return Spaceship4Render.render(spaceshipStyle);
		}

		return Spaceship5Render.render(spaceshipStyle);
	}

	function renderPropulsion(
		uint256 propulsionType,
		uint256 propulsionStyle
	) public pure returns (string memory) {
		if (propulsionType == 0) {
			return Propulsion1Render.render(propulsionStyle);
		}

		if (propulsionType == 1) {
			return Propulsion2Render.render(propulsionStyle);
		}

		return Propulsion3Render.render(propulsionStyle);
	}

	function render(
		bool flying,
		address loogieContractAddress,
		uint256 loogieId,
		uint256 spaceshipType,
		uint256 spaceshipStyle,
		uint256 propulsionType,
		uint256 propulsionStyle,
		address bowContractAddress,
		uint256 bowId
	) public view returns (string memory) {
		string memory result = "";

		if (flying) {
			NFTContract loogies = NFTContract(loogieContractAddress);
			result = string.concat(
				'<g transform="translate(100 50) scale(2.5 2.5)">',
				loogies.renderTokenById(loogieId),
				"</g>"
			);
		}

		result = string.concat(
			result,
			renderPropulsion(propulsionType, propulsionStyle),
			renderSpaceship(spaceshipType, spaceshipStyle)
		);

		if (bowId != 0) {
			NFTContract bows = NFTContract(bowContractAddress);
			result = string.concat(
				result,
				'<g transform="translate(100 50) scale(2.5 2.5)">',
				bows.renderTokenById(bowId),
				"</g>"
			);
		}

		return result;
	}
}
