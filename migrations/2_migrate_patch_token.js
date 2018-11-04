const PatchToken = artifacts.require("./PatchToken.sol");
const PatchStaking = artifacts.require("./PatchStaking.sol");

module.exports = async function(deployer) {
  await deployer.deploy(PatchToken);
  await deployer.deploy(PatchStaking);

  const patch = await PatchToken.deployed();
  const staking = await PatchStaking.deployed();

  await patch.initialize("Patch Token", "PATCH", "", staking.address);
  await patch.addDesign("ok");
  await patch.addDesign("nah");
  await patch.addDesign("word");

  await patch.startSale(1000000);

  await patch.purchase({ value: 100000000000000000 });

  await patch.pledge(0, 0);
};
