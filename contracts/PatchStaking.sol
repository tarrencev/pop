pragma solidity ^0.4.24;

import "openzeppelin-eth/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";
import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "curve-bonded-tokens/contracts/BondingCurve.sol";

/**
 * @title Token Bonding Curve
 * @dev Token backed Bonding curve contract
 */
contract PatchStaking is BondingCurve {
  using SafeMath for uint256;

  uint public contributionsRewardPool;

  mapping(address => uint) claimedRewards;

  function bondForUser(address user) public payable {
    contributionsRewardPool = contributionsRewardPool.add(msg.value);
    _curvedMintFor(user, 1);
  }

  function calculateClaimForUser(address user) internal returns (uint256) {
    uint balance = balanceOf(user);
    uint claimed = claimedRewards[user];

    /* Needs work */
    return contributionsRewardPool.mul(balance.div(totalSupply())).sub(claimed);
  }

  function claimContributionRewards() public {
    uint reward = calculateClaimForUser(msg.sender);
    msg.sender.transfer(reward);
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
