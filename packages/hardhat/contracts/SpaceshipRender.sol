//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/utils/Strings.sol";
import "base64-sol/base64.sol";
import "./HexStrings.sol";

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
	using HexStrings for uint160;

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

	function tokenURI(
		uint256 id,
		address owner,
		uint256 loogieId,
		uint256 fancyLoogieId,
		string memory svg
	) public pure returns (string memory) {
		string memory name = string.concat("SpaceLoogie #", id.toString());
		string memory description;
		if (loogieId != 0 || fancyLoogieId != 0) {
			if (loogieId != 0) {
				description = string.concat("Loogie #", loogieId.toString());
			} else {
				description = string.concat(
					"Fancy Loogie #",
					fancyLoogieId.toString()
				);
			}
			description = string.concat(description, " flying in space");
		} else {
			description = string.concat("A empty Loogie spaceship");
		}
		string memory image = Base64.encode(bytes(svg));

		return
			string(
				abi.encodePacked(
					"data:application/json;base64,",
					Base64.encode(
						bytes(
							abi.encodePacked(
								'{"name":"',
								name,
								'", "description":"',
								description,
								'", "external_url":"https://space.fancyloogies.com/spaceloogie/',
								id.toString(),
								'", "owner":"',
								(uint160(owner)).toHexString(20),
								'", "image": "',
								"data:image/svg+xml;base64,",
								image,
								'"}'
							)
						)
					)
				)
			);
	}
}
