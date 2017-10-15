const KhaCrowdsale = artifacts.require('./KhaCrowdsale.sol');
const KhaToken2 = artifacts.require("./KhaToken2.sol");

module.exports = function (deployer, network, accounts) {
  const startTime = web3.eth.getBlock(web3.eth.blockNumber).timestamp + 60; // 3 second in the future
  const endTime = startTime + 24 * 60 * 60; // 20 min
  const goal = new web3.BigNumber(200).times("1e+18");
  const rate = new web3.BigNumber(100);
  const wallet = accounts[ 0 ];

    console.log(startTime, endTime, rate, goal, goal.add('1e+18'), wallet, KhaToken2.address);
    deployer.deploy(KhaCrowdsale, startTime, endTime, rate, goal, goal.add('1e+18'), wallet, wallet, { gas: 4500000 })

};
