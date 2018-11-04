pragma solidity ^0.4.24;

import "openzeppelin-eth/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-eth/contracts/ownership/Ownable.sol";
import "openzeppelin-eth/contracts/math/SafeMath.sol";
import "curve-bonded-tokens/contracts/BondingCurve.sol";
import "zos-lib/contracts/Initializable.sol";

/**
 * @title Token Bonding Curve
 * @dev Token backed Bonding curve contract
 */
contract PatchStaking is Initializable, BondingCurve {
  using SafeMath for uint256;

  uint256 public constant INITIAL_SUPPLY = 2000;
  uint32 public constant RESERVE_RATIO = 50000;
  uint256 public constant GAS_PRICE = 50000000000 wei;

  uint256 public poolBalance_;
  uint256 public contributionsRewardPool;

  mapping(address => uint) claimedRewards;

  function initialize() initializer public {
    poolBalance_ = 1;
    BondingCurve.initialize(INITIAL_SUPPLY, RESERVE_RATIO, GAS_PRICE);
  }

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

  function poolBalance() public returns (uint256) {
    return poolBalance_;
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
