pragma solidity ^0.4.13;


import "zeppelin-solidity/contracts/token/MintableToken.sol";


/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract KhaToken2 is MintableToken {

  string public constant name = "KhaToken2";
  string public constant symbol = "KT2";
  uint8 public constant decimals = 18;

  uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
//  function SimpleToken() {
//    mint(msg.sender, INITIAL_SUPPLY);
//    mintingFinished = true;
//  }

}
