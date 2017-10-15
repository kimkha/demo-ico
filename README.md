# My Application

Test:

```
testrpc --account="0x061c3295e8cda0dd9d90121c9244fe39ae707951dae515b03f648b1e1f3f6dfa,1000000000000000000000" --account="0xfd13e7ef4558374c820925f9983e51910392d759be7c423932aa375c488464c9,2100000000000000000000"
```

```javascript
web3.personal.unlockAccount("0xedc0acfbbb909c747931f3a60c6f5cdac2e1d601", "")

account1 = web3.eth.accounts[1]
KhaCrowdsale.deployed().then(inst => { crowdsale = inst })
crowdsale.token().then(addr => { tokenAddress = addr } )
token = KhaToken.at(tokenAddress)
token.balanceOf(account1).then(balance => balance.toString(10))

crowdsale.sendTransaction({ from: account1, value: web3.toWei(5, "ether")})

```
