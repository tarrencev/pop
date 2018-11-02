pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";
import "zos-lib/contracts/upgradeability/UpgradeabilityProxyFactory.sol";

import "./PatchStaking.sol";

contract PatchToken is ERC721Token, Ownable, UpgradeabilityProxyFactory {
  using SafeMath for uint256;

  event Purchase(address indexed purchaser);
  string public metadataUri;
  uint256 public price = 100000000000000000 * 10 ** 18;
  uint256 public contributionPercent = 10;
  address public patchStakingImplementation;
  uint256 public numDesigns = 0;
  bool public endtime;

  mapping(uint256 => bool) isPledged;
  mapping(uint256 => address) patchStaking;
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

  constructor(string _name, string _symbol, string _metadataUri, address _patchStakingImplementation) ERC721Token(_name, _symbol) public {
    owner = msg.sender;
    metadataUri = _metadataUri;

    patchStakingImplementation = _patchStakingImplementation;
  }

  function addDesign(string _metadataUri) onlyOwner saleNotActive public {
    patchStaking[numDesigns] = createProxy(address(0), patchStakingImplementation);
    patchMetadata[numDesigns] = _metadataUri;

    numDesigns = numDesigns + 1;
  }

  function startSale(uint duration) onlyOwner saleNotActive public {
    endtime = now + duration;
  }

  function purchase() saleActive public payable {
    require(msg.value >= price, "Not enough ETH sent");

    uint256 tokenId = allTokens.length;
    _mint(msg.sender, tokenId);
    _setTokenURI(tokenId, metadataUri);
  }

  function pledgeToken(uint256 _patch, uint256 _tokenId) public {
    require(ownerOf(_tokenId) == msg.sender), "PatchToken: Pledger does not own token.");
    require(patchStaking[_patch] != address(0)], "PatchToken: Design does not exist.");

    PatchStaking patchStaking = patchStaking[_patch];
    patchStaking.bond()
  }
}
