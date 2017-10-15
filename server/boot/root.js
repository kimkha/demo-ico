'use strict';
const Web3 = require('web3');
const BigNumber = require('bignumber.js');
const web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));

const addr = '0xdd6b575441636d951A68Cd418ae758cA4fd5Ed52';

module.exports = function(server) {
  // Install a `/` route that returns server status
  const router = server.loopback.Router();
  // router.get('/', server.loopback.status());
  router.get('/eth', (req, res, next) => {
    web3.eth.getBalance(addr, 'latest', (err, result) => {
      const baseWei = new BigNumber('1000000000000000000'); // 10^18
      if (err) {
        next(err);
      } else {
        const val = new BigNumber(result).dividedBy(baseWei);
        res.send(`${val}`);
      }
    });
  });
  server.use(router);
};
