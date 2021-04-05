const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const Lottery = artifacts.require("Lottery");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.deploy(Lottery);
  deployer.link(ConvertLib, MetaCoin, Lottery);
  deployer.deploy(MetaCoin);
};
