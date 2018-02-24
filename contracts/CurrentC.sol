pragma solidity ^0.4.4;
//Copyright © 2018 David Ramirez

import "./AbstractTrade.sol";


/*---------------------------------------------------------------------
                           Main Contract 
-----------------------------------------------------------------------*/
contract CurrentC {

  address owner;
  address[] tradeHistory;
  address[] acceptedTradeHistory;
  uint historyTracker;
  uint acceptedHistoryTracker;

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

  //converts bytes32 type to string, used to read bytes32 type
  function bytes32ToString(bytes32 x) private constant returns (string) {
    bytes memory bytesString = new bytes(32);
    uint charCount = 0;
    for (uint j = 0; j < 32; j++) {
        byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
        if (char != 0) {
            bytesString[charCount] = char;
            charCount++;
        }
    }
    bytes memory bytesStringTrimmed = new bytes(charCount);
    for (j = 0; j < charCount; j++) {
        bytesStringTrimmed[j] = bytesString[j];
    }
    return string(bytesStringTrimmed);
}

  //makes a purchase trade contract between 2 parties and adds to trade history
  function makePurchaseTrade(address receiver) payable returns(address tradeContractAddress) {
    require(msg.sender == owner);
    address newDeploy =  new PurchaseTradeContract(owner, receiver);//tradeHistory[tradeNum - 1];
    tradeHistory.push(newDeploy);
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
    acceptedTradeHistory[acceptedHistoryTracker] = msg.sender;
    acceptedHistoryTracker++;
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

  /***********************************************************************************************************************
  *  All following "getTrade" functions return the info in readable form from the trade contract, these are needed to     *
  *  convert from bytes32 to string (ie. to read the info)                                                                *
  *************************************************************************************************************************/

  //returns the string "Firm" if trade is firm, "Non-Firm" if not
  function getTradeFirmInfo(uint index) private returns (string f) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bool firm = tradecontract.getFirm();
    
    if (firm == true) {
      f = "Firm";
    } else if (firm == false) {
      f = "Non-Firm";
    }
  }

  //returns month, day, and year (all uint) representing trade contract start date
  function getTradeStartDateInfo(uint index) private returns (uint m, uint d, uint y) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (m,d,y) = tradecontract.getStartDate();
  }

    //returns month, day, and year (all uint) representing trade contract end date
  function getTradeEndDateInfo(uint index)  private returns (uint m, uint d, uint y) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (m,d,y) = tradecontract.getEndDate();
  }

  //returns the pipe of the trade at given index
  function getTradePipeInfo(uint index) private returns (string p) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 pipe = tradecontract.getPipe();
    p = bytes32ToString(pipe);
  }

  //returns the counterparty of the trade at given index
  function getTradeCounterPartyInfo(uint index) private returns (string cp) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 counterParty = tradecontract.getCounterParty();
    cp = bytes32ToString(counterParty);
  }

  //returns the counterparty address of the trade at given index
  function getTradeCounterPartyAddressInfo(uint index) private returns (address cpa) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    address counterPartyAddress = tradecontract.getCounterPartyAddress();
    cpa = counterPartyAddress;
  }

  //returns the party of the trade at given index
  function getTradePartyInfo(uint index) private returns (string p) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 party = tradecontract.getParty();
    p = bytes32ToString(party);
  }

  //returns the counter party address of the trade at given index
  function getTradePartyAddressInfo(uint index) private returns (address pa) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    address partyAddress = tradecontract.getPartyAddress();
    pa = partyAddress;
  }

  //returns the contact of the trade at given index
  function getTradeContactInfo(uint index) private returns (string c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 contact = tradecontract.getContact();
    c = bytes32ToString(contact);
  }

  //returns the pricing method of the trade at given index
  function getTradePricingMethodInfo(uint index) private returns (string pm) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 pricingMethod = tradecontract.getPricingMethod();
    pm = bytes32ToString(pricingMethod);
  }

  //returns the trade index of the trade at given index
  function getTradeIndexInfo(uint index) private returns (uint p, uint s) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (p,s) = tradecontract.getIndex();
  }

  //returns the trade index of the trade at given index
  function getTradeIndexFactorInfo(uint index) private returns (uint p, uint s) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (p,s) = tradecontract.getIndexFactor();
  }

  //returns thefixed price of the trade at given index
  function getTradeFixedPriceInfo(uint index) private returns (uint d, uint c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (d,c) = tradecontract.getFixedPrice();
  }

  //returns the point of the trade at given index
  function getTradePointInfo(uint index) private returns (string p) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 point = tradecontract.getPoint();
    p = bytes32ToString(point);
  }

  //returns the volume of the trade at given index
  function getTradeVolumeInfo(uint index) private returns (uint d, uint c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (d,c) = tradecontract.getVolume();
  }

  //returns the comments of the trade at given index
  function getTradeComments(uint index) private returns (string c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 comments = tradecontract.getComments();
    c = bytes32ToString(comments);
  }

  //returns the volume of the trade at given index
  function getTradeTotalVolumeInfo(uint index) private returns (uint d, uint c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (d,c) = tradecontract.getTotalVolume();
  }

  //returns month, day, and year (all uint) representing trade contract deal date
  function getTradeDealDateInfo(uint index) private returns (uint m, uint d, uint y) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (m,d,y) = tradecontract.getDealDate();
  }

  //returns the total price of the trade at given index
  function getTradeTotalPriceInfo(uint index) private returns (uint d, uint c) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (d,c) = tradecontract.getTotalPrice();
  }
  
  //returns the trader of the trade at given index
  function getTradeTrader(uint index) private returns (string t) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    bytes32 trader = tradecontract.getTrader();
    t = bytes32ToString(trader);
  }

  //returns month, day, and year (all uint) representing trade contract entered on date **Note: could make this automatic**
  function getTradeEnteredOnInfo(uint index) private returns (uint m, uint d, uint y) {
    address tradeAddress = tradeHistory[index]; 
    AbstractTrade tradecontract = AbstractTrade(tradeAddress);

    (m,d,y) = tradecontract.getEnteredOn();
  }
}


/*---------------------------------------------------------------------
                       Contract for Each Purchase Trade
-----------------------------------------------------------------------*/
contract PurchaseTradeContract is AbstractTrade {

  //dummy trade constructor for testing 
  function PurchaseTradeContract(address p, address cp) AbstractTrade(p, cp) {
    internalType = 0;
  }

  //function for the counter party to accept the trade, calls main contract to add trade address to array
  function acceptTrade() payable {
    //caller of this function must be the counter party
    require(msg.sender == counterPartyAddress);
    address mainInterfaceAddress = owner; 
    CurrentC currentc = CurrentC(mainInterfaceAddress);

    currentc.acceptTradeMain();

    //makes contract read only, sending all funds it contains to the counterparty 
    selfdestruct(counterPartyAddress);
  }
}

/*---------------------------------------------------------------------
                       Contract for Each Sell Trade
-----------------------------------------------------------------------*/
contract SellTradeContract is AbstractTrade {

  //dummy trade constructor for testing 
  function SellTradeContract(address p, address cp) AbstractTrade(p, cp) {
    internalType = 1;
  }

  //function for the counter party to accept the trade, calls main contract to add trade address to array
  function acceptTrade() payable {
    //caller of this function must be the counter party
    require(msg.sender == counterPartyAddress);
    address mainInterfaceAddress = owner; 
    CurrentC currentc = CurrentC(mainInterfaceAddress);

    currentc.acceptTradeMain();

    //makes contract read only, sending all funds it contains to the party 
    selfdestruct(partyAddress);
  }
}

