pragma solidity ^0.4.19;
//Copyright © 2018 David Ramirez

import "./PurchaseTradeContract.sol";
import "./SellTradeContract.sol";


/*---------------------------------------------------------------------
                           Main Contract 
-----------------------------------------------------------------------*/
contract CurrentC {

  address internal owner;
  address[] public tradeHistory;
  address[] public acceptedTradeHistory;
  uint internal  historyTracker;
  uint internal acceptedHistoryTracker;


  //constructor: initializes number of trades for history to 0 and makes the address who deployed contract the owner
  function CurrentC() {
    historyTracker = 0;
    acceptedHistoryTracker = 0;
    owner = msg.sender;
  }

  //turns the contract into read only
  function terminateContract() {
    require(msg.sender == owner);
    selfdestruct(owner);
  }


  //function for comparing strings
  function compareStrings (string a, string b) returns (bool){
       return keccak256(a) == keccak256(b);
  }

  //makes a purchase trade contract between 2 parties and adds to trade history
  function makePurchaseTrade(address receiver) payable returns(address tradeContractAddress) {
    require(msg.sender == owner);
    address newDeploy =  new PurchaseTradeContract(owner, receiver);
    tradeHistory.push(newDeploy);
    newDeploy.transfer(msg.value);
    historyTracker += 1;
    return newDeploy;
  }

  //makes a sell trade contract between 2 parties and adds to trade history
  function makeSellTrade(address receiver) returns(address tradeContractAddress) {
    require(msg.sender == owner);
    address newDeploy =  new SellTradeContract(owner, receiver);//tradeHistory[tradeNum - 1];
    tradeHistory.push(newDeploy);
    historyTracker += 1;
    return newDeploy;
  }


  //adds trade to acceptedTradeHistory array, making it accepted by both parties (must be called by a tradeContract
  //in the tradeHistory array)
  function acceptTradeMain() {
    uint tradeCheck = 0;
    uint i = 0;

    //see if trade address is in trade history address array
    for (i; i < historyTracker;i++) {
      if (msg.sender == tradeHistory[i]) {
        tradeCheck = 1;
      }
    }

    //require the trade address to be in the array of stored trade addresses
    require(tradeCheck == 1);

    //add the calling accepting trade contract to the acceptedTradeHistory array, thus considering it
    //accepted by both parties (can only happen if counterparty accepts trade via TradeContract, and 
    //the TradeContract must be the one calling this function
    acceptedTradeHistory.push(msg.sender);
    acceptedHistoryTracker++;

    //sends event to owner that trade contract at address "msg.sender" has been accepted
    tradeAccepted(owner, msg.sender);
  }

  function declineTradeMain() {
    uint i = 0;
    uint tradeCheck = 0;
    //see if trade address is in trade history address array
    for (i; i < historyTracker;i++) {
      if (msg.sender == tradeHistory[i]) {
        tradeCheck = 1;
      }
    }

    //require the trade address to be in the array of stored trade addresses
    require(tradeCheck == 1);

    tradeDeclined(owner, msg.sender);
  }

  //returns address of owner of main CCC contract
  function getOwner() returns (address o) {
    o = owner;
  }
  
  //returns current trade num for main contract (ie. the number of trades created (not nec accepted) with main contract)
  function getTradeIndex() returns (uint tn) {
    require(msg.sender == owner);
    tn = historyTracker;
  }

  //return address of trade contract at trade history index given 
  function getHistory(uint index) returns (address t) {
    require(msg.sender == owner);
    if (index <= (historyTracker - 1)) {
      t = tradeHistory[index];
    }
  }

  /*---------------------------------------------------------------------
                       Events
-----------------------------------------------------------------------*/
  event tradeAccepted(address indexed partyAdd, address indexed tradeAdd);
  event tradeDeclined(address indexed partyAdd, address indexed tradeAdd);

}

  





