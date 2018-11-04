pragma solidity ^0.4.24;

import "openzeppelin-eth/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721Enumerable.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721Metadata.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721MetadataMintable.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";
import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "zos-lib/contracts/Initializable.sol";
import "zos-lib/contracts/upgradeability/UpgradeabilityProxy.sol";

import "./PatchStaking.sol";

contract PatchToken is Initializable, ERC721, ERC721Enumerable, ERC721Metadata, ERC721MetadataMintable, Ownable {
  using SafeMath for uint256;

  event DesignAdded(uint256 patch, address staking);
  event Purchase(address indexed purchaser);
  string public metadataUri;
  uint256 public price = 1 * 10 ** 17;
  uint256 public contributionPercent = 10;
  address public patchStakingImplementation;
  uint256 public numPatches = 0;
  uint256 public endtime;

  mapping(uint256 => bool) isPledged;
  mapping(uint256 => PatchStaking) patchStaking;
  mapping(uint256 => string) patchMetadata;

  modifier saleNotActive() {
    require(endtime == 0, "PatchToken: Sale has started.");
    _;
  }

  modifier saleActive() {
    require(endtime != 0, "PatchToken: Sale not active.");
    require(now < endtime, "PatchToken: Sale not active.");
    _;
  }

  function initialize(string _name, string _symbol, string _metadataUri, address _patchStakingImplementation) initializer public {
    ERC721.initialize();
    ERC721Enumerable.initialize();
    ERC721Metadata.initialize(_name, _symbol);
    ERC721MetadataMintable.initialize(address(this));
    Ownable.initialize(msg.sender);

    metadataUri = _metadataUri;

    patchStakingImplementation = _patchStakingImplementation;
  }

  function addDesign(string _metadataUri) onlyOwner saleNotActive public {
    uint patch = numPatches;
    PatchStaking patchStake = PatchStaking(new UpgradeabilityProxy(patchStakingImplementation, ""));
    patchStake.initialize();
    patchStaking[patch] = patchStake;
    patchMetadata[patch] = _metadataUri;

    numPatches = numPatches + 1;
    emit DesignAdded(patch, patchStake);
  }

  function startSale(uint duration) onlyOwner saleNotActive public {
    endtime = now + duration;
  }

  function purchase() saleActive public payable {
    require(msg.value >= price, "Not enough ETH sent");

    uint256 tokenId = totalSupply();
    _mint(msg.sender, tokenId);
    _setTokenURI(tokenId, metadataUri);
  }

  function pledge(uint256 _patch, uint256 _tokenId) public {
    require(ownerOf(_tokenId) == msg.sender, "PatchToken: Pledger does not own token.");
    require(patchStaking[_patch] != address(0), "PatchToken: Design does not exist.");
    require(isPledged[_tokenId] == false, "PatchToken: Token is already pledged.");

    PatchStaking patchStake = patchStaking[_patch];
    patchStake.bondForUser.value(price)(msg.sender);
  }
}
