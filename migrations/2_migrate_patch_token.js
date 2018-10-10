const PatchToken = artifacts.require("./PatchToken.sol");

module.exports = async function(deployer) {
  deployer.deploy(PatchToken, "Patch Token", "PATCH", "test");
};
