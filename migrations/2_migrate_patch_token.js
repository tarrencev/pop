const PatchToken = artifacts.require("./PatchToken.sol");

module.exports = async function(deployer) {
  await deployer.deploy(PatchToken, "Patch Token", "PATCH", "test");
};
