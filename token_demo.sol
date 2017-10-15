pragma solidity ^0.4.13;


// Init: 100000000, MyAwesomeToken, MAT1, 4
// 0xBD4FC6F85e9445EF26e2945007E31B81D4B8b0F8
contract MyToken {
  // This creates an array with all balances
  mapping (address => uint256) public balanceOf;

  string public name;

  string public symbol;

  uint8 public decimals;

  address creator;

  event Transfer(address indexed from, address indexed to, uint256 value);

  function MyToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUnits) {
    // Give the creator all initial tokens
    creator = msg.sender;
    balanceOf[creator] = initialSupply;
    // Set the name for display purposes
    name = tokenName;
    // Set the symbol for display purposes
    symbol = tokenSymbol;
    // Amount of decimals for display purposes
    decimals = decimalUnits;
  }

  function redeem(address _to, uint256 _value) {
    // Check if sender has balance and for overflows
    require(balanceOf[creator] >= _value && balanceOf[_to] + _value >= balanceOf[_to]);

    // Add and subtract new balances
    balanceOf[creator] -= _value;
    balanceOf[_to] += _value;

    // Notify anyone listening that this transfer took place
    Transfer(creator, _to, _value);
  }
}
