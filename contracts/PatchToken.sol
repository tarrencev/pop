pragma solidity ^0.4.18;

import "zos-lib/contracts/migrations/Initializable.sol";
import "openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./Medianizer.sol";

contract PatchToken is ERC721Token, Ownable {
  using SafeMath for uint256;

  event Purchase(address indexed purchaser, string metadata);
  string public metadataUri;
  uint256 public price = 20000000000000000000 * 10 ** 18;

  Medianizer public medianizer = Medianizer(0xE39451e34f8FB108a8F6d4cA6C68dd38f37d26E3);
  /* Medianizer public medianizer = Medianizer(0x729D19f657BD0614b4985Cf1D82531c67569197B); */

  constructor(string _name, string _symbol, string _metadataUri) ERC721Token(_name, _symbol) public {
    owner = msg.sender;
    metadataUri = _metadataUri;
  }

  function calculatePrice(uint8 id) public returns (uint256) {
    var (ethPrice, ok) = medianizer.peek();

    return price.div(uint256(ethPrice));
  }

  function purchase(uint8 id) public payable {
    require(msg.value >= calculatePrice(), "Not enough ETH sent");

    uint256 tokenId = allTokens.length;
    _mint(msg.sender, tokenId);
    _setTokenURI(tokenId, metadataUri);

    emit Purchase(msg.sender, metadata);
  }
}
