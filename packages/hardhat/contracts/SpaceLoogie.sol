//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
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

abstract contract LoogiesContract {
	function renderTokenById(
		uint256 id
	) external view virtual returns (string memory);

	function transferFrom(
		address from,
		address to,
		uint256 tokenId
	) external virtual;
}

abstract contract NFTContract {
	function renderTokenById(
		uint256 id
	) external view virtual returns (string memory);

	function transferFrom(
		address from,
		address to,
		uint256 id
	) external virtual;
}

contract SpaceLoogie is ERC721Enumerable, IERC721Receiver, Ownable {
	using Strings for uint256;
	using Strings for uint8;
	using HexStrings for uint160;
	using Counters for Counters.Counter;

	Counters.Counter private _tokenIds;

	LoogiesContract loogies;
	LoogiesContract fancyLoogies;
	NFTContract bows;

	mapping(uint256 => uint256) public loogieById;
	mapping(uint256 => uint256) public fancyLoogieById;
	mapping(uint256 => uint256) public bowById;
	mapping(uint256 => uint256) public spaceshipTypeById;
	mapping(uint256 => uint256) public propulsionTypeById;
	mapping(uint256 => uint256) public spaceshipStyleById;
	mapping(uint256 => uint256) public propulsionStyleById;

	mapping(uint256 => bool) public usedLoogies;
	mapping(uint256 => bool) public usedFancyLoogies;

	constructor(
		address _loogies,
		address _fancyLoogies,
		address _bows
	) ERC721("SpaceLoogie", "SLOOG") {
		loogies = LoogiesContract(_loogies);
		fancyLoogies = LoogiesContract(_fancyLoogies);
		bows = NFTContract(_bows);
	}

	function mintItemWithLoogie(uint256 loogieId) public returns (uint256) {
		require(!usedLoogies[loogieId], "you can't use the same loogie twice!");
		usedLoogies[loogieId] = true;

		_tokenIds.increment();

		uint256 id = _tokenIds.current();
		_mint(msg.sender, id);

		loogies.transferFrom(msg.sender, address(this), loogieId);

		loogieById[id] = loogieId;

		bytes32 predictableRandom = keccak256(
			abi.encodePacked(
				id,
				blockhash(block.number - 1),
				msg.sender,
				address(this)
			)
		);

		spaceshipTypeById[id] = uint256(uint8(predictableRandom[0])) % 5;
		spaceshipStyleById[id] = uint256(uint8(predictableRandom[1])) % 6;
		propulsionTypeById[id] = uint256(uint8(predictableRandom[2])) % 3;
		propulsionStyleById[id] = uint256(uint8(predictableRandom[3])) % 5;

		// spaceshipTypeById[id] = 4;
		// spaceshipStyleById[id] = id - 1;
		// propulsionTypeById[id] = 2;
		// propulsionStyleById[id] = id - 1;

		return id;
	}

	function mintItemWithFancyLoogie(
		uint256 fancyLoogieId
	) public returns (uint256) {
		require(
			!usedFancyLoogies[fancyLoogieId],
			"you can't use the same fancy loogie twice!"
		);
		usedFancyLoogies[fancyLoogieId] = true;

		_tokenIds.increment();

		uint256 id = _tokenIds.current();
		_mint(msg.sender, id);

		fancyLoogies.transferFrom(msg.sender, address(this), fancyLoogieId);

		fancyLoogieById[id] = fancyLoogieId;

		bytes32 predictableRandom = keccak256(
			abi.encodePacked(
				id,
				blockhash(block.number - 1),
				msg.sender,
				address(this)
			)
		);

		// spaceshipStyleById[id] = uint256(uint8(predictableRandom[0])) % 6;
		// propulsionStyleById[id] = uint256(uint8(predictableRandom[1])) % 5;

		spaceshipStyleById[id] = id - 1;
		propulsionStyleById[id] = id - 1;

		return id;
	}

	function tokenURI(uint256 id) public view override returns (string memory) {
		require(_exists(id), "not exist");
		string memory name = string(
			abi.encodePacked("SpaceLoogie #", id.toString())
		);
		string memory description = string(
			abi.encodePacked("OptimisticLoogie flying in space")
		);
		string memory image = Base64.encode(bytes(_generateSVGofTokenById(id)));

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
								(uint160(ownerOf(id))).toHexString(20),
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

	function _generateSVGofTokenById(
		uint256 id
	) internal view returns (string memory) {
		string memory svg = string(
			abi.encodePacked(
				'<svg width="1200" height="1582" viewBox="0 0 1200 1582" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">',
				renderTokenById(id),
				"</svg>"
			)
		);

		return svg;
	}

	// Visibility is `public` to enable it being called by other contracts for composition.
	function renderTokenById(uint256 id) public view returns (string memory) {
		require(_exists(id), "not exist");

		string memory render;

		render = string.concat(
			'<g transform="translate(100 50) scale(2.5 2.5)">',
			loogies.renderTokenById(loogieById[id]),
			"</g>"
		);

		render = string.concat(render, renderPropulsion(id));

		render = string.concat(render, renderSpaceship(id));

		return render;
	}

	function renderSpaceship(uint256 id) public view returns (string memory) {
		require(_exists(id), "not exist");

		if (spaceshipTypeById[id] == 0) {
			return Spaceship1Render.render(spaceshipStyleById[id]);
		}

		if (spaceshipTypeById[id] == 1) {
			return Spaceship2Render.render(spaceshipStyleById[id]);
		}

		if (spaceshipTypeById[id] == 2) {
			return Spaceship3Render.render(spaceshipStyleById[id]);
		}

		if (spaceshipTypeById[id] == 3) {
			return Spaceship4Render.render(spaceshipStyleById[id]);
		}

		return Spaceship5Render.render(spaceshipStyleById[id]);
	}

	function renderPropulsion(uint256 id) public view returns (string memory) {
		require(_exists(id), "not exist");

		if (propulsionTypeById[id] == 0) {
			return Propulsion1Render.render(propulsionStyleById[id]);
		}

		if (propulsionTypeById[id] == 1) {
			return Propulsion2Render.render(propulsionStyleById[id]);
		}

		return Propulsion3Render.render(propulsionStyleById[id]);
	}

	// https://github.com/GNSPS/solidity-bytes-utils/blob/master/contracts/BytesLib.sol#L374
	function _toUint256(bytes memory _bytes) internal pure returns (uint256) {
		require(_bytes.length >= 32, "toUint256_outOfBounds");
		uint256 tempUint;

		assembly {
			tempUint := mload(add(_bytes, 0x20))
		}

		return tempUint;
	}

	function getOriginalLoogie(uint256 id) external {
		require(
			msg.sender == ownerOf(id),
			"only the owner can get the original loogie!"
		);

		// transfer loogie to owner
		loogies.transferFrom(address(this), ownerOf(id), loogieById[id]);
		loogieById[id] = 0;

		// burn SpaceLoogie
		_burn(id);
	}

	function tokenIdsFromOwner(
		address owner
	) external view returns (uint256[] memory) {
		uint256 tokenCount = balanceOf(owner);
		uint256[] memory tokenIds = new uint256[](tokenCount);
		for (uint256 i = 0; i < tokenCount; i++) {
			tokenIds[i] = tokenOfOwnerByIndex(owner, i);
		}
		return tokenIds;
	}

	// to receive ERC721 tokens
	function onERC721Received(
		address operator,
		address from,
		uint256 tokenId,
		bytes calldata fancyIdData
	) external override returns (bytes4) {
		uint256 fancyId = _toUint256(fancyIdData);

		require(
			ownerOf(fancyId) == from,
			"you can only add stuff to a space loogie you own."
		);
		require(
			msg.sender == address(bows),
			"the space loogies can't wear this NFT"
		);
		require(bowById[fancyId] == 0, "the space loogie already has a bow!");

		bowById[fancyId] = tokenId;

		return this.onERC721Received.selector;
	}
}
