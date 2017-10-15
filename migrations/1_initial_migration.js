var KhaToken2 = artifacts.require("./KhaToken2.sol");

module.exports = function(deployer) {
  // web3.personal.unlockAccount(web3.eth.accounts[0], '');
  deployer.deploy(KhaToken2);
  // deployer.deploy(GustavoCoin);
};
