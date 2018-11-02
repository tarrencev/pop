pragma solidity ^0.4.24;

import "zos-lib/contracts/Initializable.sol";
import "openzeppelin-eth/contracts/token/ERC721/ERC721.sol";

import "./BondingCurve.sol";

/**
 * @title Token Bonding Curve
 * @dev Token backed Bonding curve contract
 */
contract PatchStaking is BondingCurve, Initializable {
  /* Reserve Token */
  ERC721 public reserveToken;
  uint public contributionsRewardPool;

  mapping(address => uint) claimedRewards;

  function initialize(ERC721 _reserveToken) initializer public {
    reserveToken = _reserveToken;
  }

  /**
   * @dev Mint tokens
   *
   * @param amount Amount of tokens to deposit
   */
  function bondForUser(address ) public {
    _curvedMint(1);
  }

  function calculateClaimForUser(address user) {
    uint balance = balanceOf(user);

  }

  function claimContributionRewards() {

  }

  function () public payable {

  }

  function transfer(address to, uint256 value) public returns (bool) {
    revert();
  }

  function transferFrom(
    address from,
    address to,
    uint256 value
  )
    public
    returns (bool)
  {
    revert();
  }
}
