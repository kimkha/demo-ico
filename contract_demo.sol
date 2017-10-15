pragma solidity ^0.4.13;


interface token {
  function redeem(address receiver, uint amount);
}
// token: 0x499fc50Eeb4B5D4438c4588fD2926BB4f930b392
// main account: 0xEDc0acFBbB909c747931f3A60c6f5CdaC2e1d601

contract Crowdsale {
  address public beneficiary;

  uint public fundingGoal;

  uint public amountRaised;

  uint public deadline;

  uint public price;

  token public tokenReward;

  mapping (address => uint256) public balanceOf;

  address creator;

  bool fundingGoalReached = false;

  bool crowdsaleClosed = false;

  event GoalReached(address beneficiary, uint amountRaised);

  event FundTransfer(address backer, uint amount, bool isContribution);

  event DebugLog(address from, uint amount, uint price);

  /**
   * Constrctor function
   *
   * Setup the owner
   */
  function Crowdsale(address ifSuccessfulSendTo, uint fundingGoalInEthers, uint durationInMinutes, uint tokensOfEachEther, address addressOfTokenUsedAsReward) {
    creator = msg.sender;
    beneficiary = ifSuccessfulSendTo;
    fundingGoal = fundingGoalInEthers * 1 ether;
    deadline = now + durationInMinutes * 1 minutes;
    price = tokensOfEachEther;
    tokenReward = token(addressOfTokenUsedAsReward);
  }

  /**
   * Fallback function
   *
   * The function without name is the default function that is called whenever anyone sends funds to a contract
   */
  function() payable {
    require(!crowdsaleClosed);
    uint amount = msg.value;
    DebugLog(msg.sender, amount, price);
    balanceOf[msg.sender] += amount;
    amountRaised += amount;
    tokenReward.redeem(msg.sender, amount * price);
    FundTransfer(msg.sender, amount, true);
  }

  modifier afterDeadline() {if (now >= deadline) _;}

  /**
   * Check if goal was reached
   *
   * Checks if the goal or time limit has been reached and ends the campaign
   */
  function checkGoalReached() afterDeadline {
    if (amountRaised >= fundingGoal) {
      fundingGoalReached = true;
      GoalReached(beneficiary, amountRaised);
    }
    crowdsaleClosed = true;
  }


  /**
   * Withdraw the funds
   *
   * Checks to see if goal or time limit has been reached, and if so, and the funding goal was reached,
   * sends the entire amount to the beneficiary. If goal was not reached, each contributor can withdraw
   * the amount they contributed.
   */
  function safeWithdrawal() afterDeadline {
    if (!fundingGoalReached) {
      uint amount = balanceOf[msg.sender];
      balanceOf[msg.sender] = 0;
      if (amount > 0) {
        if (msg.sender.send(amount)) {
          FundTransfer(msg.sender, amount, false);
        }
        else {
          balanceOf[msg.sender] = amount;
        }
      }
    }

    if (fundingGoalReached && beneficiary == msg.sender) {
      if (beneficiary.send(amountRaised)) {
        FundTransfer(beneficiary, amountRaised, false);
      }
      else {
        //If we fail to send the funds to beneficiary, unlock funders balance
        fundingGoalReached = false;
      }
    }
  }
}
