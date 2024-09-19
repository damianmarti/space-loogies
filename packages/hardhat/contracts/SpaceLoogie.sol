//SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./SpaceshipRender.sol";

abstract contract LoogieCoinContract {
	function burn(address from, uint256 amount) public virtual;

	function balanceOf(address account) public view virtual returns (uint256);
}

contract SpaceLoogie is ERC721, IERC721Receiver, Ownable {
	using Counters for Counters.Counter;

	Counters.Counter private _tokenIds;

	NFTContract loogies;
	NFTContract fancyLoogies;
	NFTContract bows;
	LoogieCoinContract loogieCoin;

	struct Spaceship {
		uint256 spaceshipType;
		uint256 spaceshipStyle;
		uint256 propulsionType;
		uint256 propulsionStyle;
		uint256 loogieId;
		uint256 fancyLoogieId;
		uint256 bowId;
		uint256 kms;
		uint256 speed;
		uint256 lastSpeedUpdate;
		bool flying;
		bool free;
	}

	// all funds go to buidlguidl.eth
	address payable public constant recipient =
		payable(0xa81a6a910FeD20374361B35C451a4a44F86CeD46);
	uint256 public price = 0.005 ether;

	mapping(uint256 => Spaceship) public spaceships;
	mapping(uint256 => bool) public usedLoogies;
	mapping(uint256 => bool) public usedFancyLoogies;

	event SpeedUpdate(uint256 indexed id, uint256 speed, uint256 kms);
	event RenderUpdate(uint256 indexed id);

	constructor(
		address _loogies,
		address _fancyLoogies,
		address _bows,
		address _loogieCoin
	) ERC721("SpaceLoogie", "SLOOG") {
		loogies = NFTContract(_loogies);
		fancyLoogies = NFTContract(_fancyLoogies);
		bows = NFTContract(_bows);
		loogieCoin = LoogieCoinContract(_loogieCoin);
	}

	function mintItem(
		uint256 crewId,
		bool free,
		bool fancy
	) internal returns (uint256) {
		_tokenIds.increment();

		uint256 id = _tokenIds.current();
		_mint(msg.sender, id);

		if (free) {
			if (fancy) {
				fancyLoogies.transferFrom(msg.sender, address(this), crewId);
			} else {
				loogies.transferFrom(msg.sender, address(this), crewId);
			}
		}

		bytes32 predictableRandom = keccak256(
			abi.encodePacked(
				id,
				blockhash(block.number - 1),
				msg.sender,
				address(this)
			)
		);

		Spaceship memory spaceship = Spaceship({
			spaceshipType: uint256(uint8(predictableRandom[0])) % 5,
			spaceshipStyle: uint256(uint8(predictableRandom[1])) % 6,
			propulsionType: uint256(uint8(predictableRandom[2])) % 3,
			propulsionStyle: uint256(uint8(predictableRandom[3])) % 5,
			loogieId: fancy ? 0 : crewId,
			fancyLoogieId: fancy ? crewId : 0,
			bowId: 0,
			flying: free,
			kms: 0,
			speed: free ? 1 : 0,
			lastSpeedUpdate: block.number,
			free: free
		});

		spaceships[id] = spaceship;

		return id;
	}

	function mintItemWithEth() public payable returns (uint256) {
		require(msg.value >= price, "NOT ENOUGH");

		(bool success, ) = recipient.call{ value: msg.value }("");
		require(success, "could not send");

		return mintItem(0, false, false);
	}

	function mintItemWithLoogie(uint256 loogieId) public returns (uint256) {
		require(!usedLoogies[loogieId], "you can't use the same loogie twice!");
		usedLoogies[loogieId] = true;

		return mintItem(loogieId, true, false);
	}

	function mintItemWithFancyLoogie(
		uint256 fancyLoogieId
	) public returns (uint256) {
		require(
			!usedFancyLoogies[fancyLoogieId],
			"you can't use the same fancy loogie twice!"
		);
		usedFancyLoogies[fancyLoogieId] = true;

		return mintItem(fancyLoogieId, true, true);
	}

	function totalKms(uint256 id) public view returns (uint256) {
		require(_exists(id), "not exist");

		uint256 timePassed = block.number - spaceships[id].lastSpeedUpdate;
		uint256 distance = timePassed * spaceships[id].speed;
		return spaceships[id].kms + distance;
	}

	function speedUp(uint256 id, uint256 amount) public {
		require(_exists(id), "not exist");
		require(
			ownerOf(id) == msg.sender,
			"only the owner can accelerate the spaceship!"
		);
		require(spaceships[id].flying, "the spaceship is not flying!");
		require(amount > 0, "amount must be greater than 0");
		require(
			loogieCoin.balanceOf(msg.sender) >= (amount * 1000),
			"you don't have enough LoogieCoins"
		);

		uint256 timePassed = block.number - spaceships[id].lastSpeedUpdate;
		uint256 distance = timePassed * spaceships[id].speed;
		spaceships[id].kms += distance;
		spaceships[id].speed += amount;
		spaceships[id].lastSpeedUpdate = block.number;

		loogieCoin.burn(msg.sender, amount * 1000);

		emit SpeedUpdate(id, spaceships[id].speed, spaceships[id].kms);
	}

	function tokenURI(uint256 id) public view override returns (string memory) {
		require(_exists(id), "not exist");

		return
			SpaceshipRender.tokenURI(
				id,
				ownerOf(id),
				spaceships[id].loogieId,
				spaceships[id].fancyLoogieId,
				_generateSVGofTokenById(id)
			);
	}

	function _generateSVGofTokenById(
		uint256 id
	) internal view returns (string memory) {
		return
			string(
				abi.encodePacked(
					'<svg width="1200" height="1582" viewBox="0 0 1200 1582" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">',
					renderTokenById(id),
					"</svg>"
				)
			);
	}

	// Visibility is `public` to enable it being called by other contracts for composition.
	function renderTokenById(uint256 id) public view returns (string memory) {
		require(_exists(id), "not exist");

		return
			SpaceshipRender.render(
				spaceships[id].flying,
				spaceships[id].loogieId != 0
					? address(loogies)
					: address(fancyLoogies),
				spaceships[id].loogieId != 0
					? spaceships[id].loogieId
					: spaceships[id].fancyLoogieId,
				spaceships[id].spaceshipType,
				spaceships[id].spaceshipStyle,
				spaceships[id].propulsionType,
				spaceships[id].propulsionStyle,
				address(bows),
				spaceships[id].bowId
			);
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
		require(spaceships[id].flying, "the loogie is not in the spaceship!");

		if (spaceships[id].loogieId != 0) {
			loogies.transferFrom(
				address(this),
				ownerOf(id),
				spaceships[id].loogieId
			);
			if (!spaceships[id].free) {
				spaceships[id].loogieId = 0;
			}
		} else {
			fancyLoogies.transferFrom(
				address(this),
				ownerOf(id),
				spaceships[id].fancyLoogieId
			);
			if (!spaceships[id].free) {
				spaceships[id].fancyLoogieId = 0;
			}
		}

		spaceships[id].flying = false;

		uint256 timePassed = block.number - spaceships[id].lastSpeedUpdate;
		uint256 distance = timePassed * spaceships[id].speed;
		spaceships[id].kms += distance;
		spaceships[id].speed = 0;
		spaceships[id].lastSpeedUpdate = block.number;

		emit SpeedUpdate(id, 0, spaceships[id].kms);
		emit RenderUpdate(id);
	}

	function getBow(uint256 id) external {
		require(msg.sender == ownerOf(id), "only the owner can get the bow!");
		require(spaceships[id].bowId != 0, "the spaceship doesn't have a bow!");

		bows.transferFrom(address(this), ownerOf(id), spaceships[id].bowId);
		spaceships[id].bowId = 0;

		emit RenderUpdate(id);
	}

	// to receive ERC721 tokens
	function onERC721Received(
		address operator,
		address from,
		uint256 tokenId,
		bytes calldata spaceLoogieIdData
	) external override returns (bytes4) {
		uint256 spaceLoogieId = _toUint256(spaceLoogieIdData);

		require(
			ownerOf(spaceLoogieId) == from,
			"you can only add stuff to a space loogie you own."
		);
		require(
			msg.sender == address(bows) ||
				msg.sender == address(loogies) ||
				msg.sender == address(fancyLoogies),
			"you can't add this NFT to a space loogie"
		);

		if (msg.sender == address(bows)) {
			require(
				spaceships[spaceLoogieId].bowId == 0,
				"the space loogie already has a bow!"
			);

			spaceships[spaceLoogieId].bowId = tokenId;
		}

		if (msg.sender == address(loogies)) {
			require(
				!spaceships[spaceLoogieId].flying,
				"the space loogie is flying!"
			);
			require(
				!spaceships[spaceLoogieId].free ||
					spaceships[spaceLoogieId].loogieId == tokenId,
				"this is not the space loogie owned by this loogie!"
			);
			spaceships[spaceLoogieId].flying = true;
			if (!spaceships[spaceLoogieId].free) {
				spaceships[spaceLoogieId].loogieId = tokenId;
			}
		}

		if (msg.sender == address(fancyLoogies)) {
			require(
				!spaceships[spaceLoogieId].flying,
				"the space loogie is flying!"
			);
			require(
				!spaceships[spaceLoogieId].free ||
					spaceships[spaceLoogieId].fancyLoogieId == tokenId,
				"this is not the space loogie owned by this fancy loogie!"
			);
			spaceships[spaceLoogieId].flying = true;
			if (!spaceships[spaceLoogieId].free) {
				spaceships[spaceLoogieId].fancyLoogieId = tokenId;
			}
		}

		if (
			msg.sender == address(loogies) ||
			msg.sender == address(fancyLoogies)
		) {
			spaceships[spaceLoogieId].speed = 1;
			spaceships[spaceLoogieId].lastSpeedUpdate = block.number;

			emit SpeedUpdate(spaceLoogieId, 1, spaceships[spaceLoogieId].kms);
		}

		emit RenderUpdate(spaceLoogieId);

		return this.onERC721Received.selector;
	}
}
