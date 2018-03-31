pragma solidity ^0.4.19;

//import "./CurrentC.sol";

//abstract contract for use with purchase or sell trades (only difference is internalType value and acceptTrade function)
contract AbstractTrade {

  //for date type
  struct dateStruct {
    uint month;
    uint day;
    uint year;
  }

  //for price type
  struct priceStruct {
    uint dollars;
    uint cents;
  }

  //for float type (floats not yet supported by solidity, cannot do math with this struct, set and read only)
  struct decimalNumberStruct {
    uint prefix;
    uint suffix;
  }

/***********************************************
          MEMBER VARIABLE DECLARATIONS         
************************************************/
  address public owner;
  //6
  bool public firm;

  //7 
  dateStruct public startDate;

  //8 
  dateStruct public endDate;

  //9 
  string public pipe;

  //10
  string public counterParty;
  address public counterPartyAddress;

  //10.b
  string public party;

  address public partyAddress;

  //11
  string public contact;

  //13
  string public pricingMethod;

  //14 
  decimalNumberStruct public index;

  //15
  decimalNumberStruct public indexFactor;

  //16 
  priceStruct public fixedPrice;
  //17 (not sure what this parameter is, need to consult Tim)
  string public point;

  decimalNumberStruct public volume;

  //18
  string public comments;

  //19 (solidity does not yet support fixed point numbers)
  decimalNumberStruct public totalVolume;

  //20
  dateStruct public dealDate;

  //21 
  priceStruct public totalPrice;

  //22
  string public trader;

  //23 (seems to be auto filled in front end, will just get from there instead
  //    of aut filling date here)
  dateStruct public enteredOn;

  //keeps track of if purchase or sell trade (0 if purchase, 1 if sell)
  uint public internalType;

  //dummy trade constructor for testing
  function AbstractTrade(address p , address cp) {
    firm = true;
    startDate.month = 1;
    startDate.day = 1;
    startDate.year = 1;
    endDate.month = 1;
    endDate.day = 1;
    endDate.year = 1; 
    dealDate.month = 1;
    dealDate.day = 1;
    dealDate.year = 1;
    pipe = "pipe";
    counterParty = "counterparty";
    counterPartyAddress =cp;
    party = "party";
    partyAddress = p;
    contact = "contact";
    //setPortfolio("portolio");
    pricingMethod = "pricingmethod";
    index.prefix = 1;
    index.suffix = 1;
    indexFactor.prefix = 1;
    indexFactor.suffix = 1;
    point = "point";
    volume.prefix = 1;
    volume.suffix = 1;
    fixedPrice.dollars = 1;
    fixedPrice.cents = 1;
    comments = "comments";
    totalVolume.prefix = 1;
    totalVolume.suffix = 1;
    totalPrice.dollars = 1;
    totalPrice.cents = 1;
    owner = msg.sender;
  }


/***********************************************
                 SET FUNCTIONS                   
************************************************/

  function setFirm(bool f) public {
    require(msg.sender == partyAddress);
    firm = f;
  }

  function setStartDate(uint m, uint d, uint y) public {
    require(msg.sender == partyAddress);
    startDate.month = m;
    startDate.day = d;
    startDate.year = y;
  }

  function setEndDate(uint m, uint d, uint y) public {
    require(msg.sender == partyAddress);
    endDate.month = m;
    endDate.day = d;
    endDate.year = y;
  }

  function setPipe(string p) public {
    require(msg.sender == partyAddress);
    pipe = p;
  }

  function setCounterParty(string cp) public {
    require(msg.sender == partyAddress);
    counterParty = cp;
  }

  function setCounterPartyAddress(address cp) public {
    require(msg.sender == partyAddress);
    counterPartyAddress = cp;
  }

  function setParty(string p) public {
    require(msg.sender == partyAddress);
    party = p;
  }

  function setPartyAddress(address p) public {
    require(msg.sender == partyAddress);
    partyAddress = p;
  }

  function setContact(string c) public {
    require(msg.sender == partyAddress);
    contact = c;
  }

  function setPricingMethod(string pm) public {
    require(msg.sender == partyAddress);
    pricingMethod = pm;
  }

  function setIndex(uint p, uint s) public {
    require(msg.sender == partyAddress);
    index.prefix = p;
    index.suffix = s;
  }

  function setIndexFactor(uint p, uint s) public {
    require(msg.sender == partyAddress);
    indexFactor.prefix = p;
    indexFactor.suffix = s;
  }

  function setFixedPrice(uint d, uint c) public {
    require(msg.sender == partyAddress);
    fixedPrice.dollars = d;
    fixedPrice.cents = c;
  }

  function setPoint(string p) public {
    require(msg.sender == partyAddress);
    point = p;
  }

  function setVolume(uint p, uint s) public {
    require(msg.sender == partyAddress);
    volume.prefix = p;
    volume.suffix = s;
  }

  function setComments(string c) public {
    require(msg.sender == partyAddress);
    comments = c;
  }

  function setTotalVolume(uint p, uint s) public {
    require(msg.sender == partyAddress);
    totalVolume.prefix = p;
    totalVolume.suffix = s;
  }

  function setDealDate(uint m, uint d, uint y) public {
    require(msg.sender == partyAddress);
    dealDate.month = m;
    dealDate.day = d;
    dealDate.year = y;
  }

  function setTotalPrice(uint d, uint c) public {
    require(msg.sender == partyAddress);
    totalPrice.dollars = d;
    totalPrice.cents = c;
  }

  function setTrader(string t) public {
    require(msg.sender == partyAddress);
    trader = t;
  }

  function setEnteredOn(uint m, uint d, uint y) public {
    require(msg.sender == partyAddress);
    enteredOn.month = m;
    enteredOn.day = d;
    enteredOn.year = y;
  }


/***********************************************
                 GET FUNCTIONS                   
************************************************/
/*

  function getFirm() returns (bool f) {
    require(msg.sender == owner);
    f = firm;
  }

  function getStartDate() returns (uint m, uint d, uint y) {
    require(msg.sender == owner);
    m = startDate.month;
    d = startDate.day;
    y = startDate.year;
  }

  function getEndDate() returns (uint m, uint d, uint y) {
    require(msg.sender == owner);
    m = endDate.month;
    d = endDate.day;
    y = endDate.year;
  }

  function getPipe() returns (string p) {
    require(msg.sender == owner);
    p = pipe;
  }

  function getCounterParty() returns (string cp) {
    require(msg.sender == owner);
    cp = counterParty;
  }

  function getCounterPartyAddress() returns (address cp) {
    require(msg.sender == owner);
    cp = counterPartyAddress;
  }

  function getParty() returns (string p) {
    require(msg.sender == owner);
    p = party;
  }

  function getPartyAddress() returns (address p) {
    require(msg.sender == owner);
    p = partyAddress;
  }

  function getContact() returns (string c) {
    require(msg.sender == owner);
    c = contact;
  }

  function getPricingMethod() returns (string pm) {
    require(msg.sender == owner);
    pm = pricingMethod;
  }

  function getIndex() returns (uint p, uint s) {
    require(msg.sender == owner);
    p = index.prefix;
    s = index.suffix;
  }

  function getIndexFactor() returns (uint p, uint s) {
    require(msg.sender == owner);
    p = indexFactor.prefix;
    s = indexFactor.suffix;
  }

  function getFixedPrice() returns (uint d, uint c) {
    require(msg.sender == owner);
    d = fixedPrice.dollars;
    c = fixedPrice.cents;
  }

  function getPoint() returns (string p) {
    require(msg.sender == owner);
    p = point;
  }

  function getComments() returns (string c) {
    require(msg.sender == owner);
    c = comments;
  }

  function getVolume() returns (uint p, uint s) {
    require(msg.sender == owner);
    p = volume.prefix;
    s = volume.suffix;
  }

  function getTotalVolume() returns (uint p, uint s) {
    require(msg.sender == owner);
    p = totalVolume.prefix;
    s = totalVolume.suffix;
  }

  function getDealDate() returns (uint m, uint d, uint y) {
    require(msg.sender == owner);
    m = dealDate.month;
    d = dealDate.day;
    y = dealDate.year;
  }

  function getTotalPrice() returns (uint d, uint c) {
    require(msg.sender == owner);
    d = totalPrice.dollars;
    c = totalPrice.cents;
  }

  function getTrader() returns (string t) {
    require(msg.sender == owner);
    t = trader;
  }

  function getEnteredOn() returns (uint m, uint d, uint y) {
    require(msg.sender == owner);
    m = enteredOn.month;
    d = enteredOn.day;
    y = enteredOn.year;
  }

  */

  //function for the counter party to accept the trade, calls main contract to add trade address to array
  function acceptTrade() payable;

  function declineTrade();

  function() public payable { }
}