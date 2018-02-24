pragma solidity ^0.4.4;

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
  address owner;
  //6
  bool firm;

  //7 
  dateStruct startDate;

  //8 
  dateStruct endDate;

  //9 
  bytes32 pipe;

  //10
  bytes32 counterParty;

  address counterPartyAddress;

  //10.b
  bytes32 party;

  address partyAddress;

  //11
  bytes32 contact;

  //13
  bytes32 pricingMethod;

  //14 
  decimalNumberStruct index;

  //15
  decimalNumberStruct indexFactor;

  //16 
  priceStruct fixedPrice;
  //17 (not sure what this parameter is, need to consult Tim)
  bytes32 point;

  decimalNumberStruct volume;

  //18
  bytes32 comments;

  //19 (solidity does not yet support fixed point numbers)
  decimalNumberStruct totalVolume;

  //20
  dateStruct dealDate;

  //21 
  priceStruct totalPrice;

  //22
  bytes32 trader;

  //23 (seems to be auto filled in front end, will just get from there instead
  //    of aut filling date here)
  dateStruct enteredOn;

  //keeps track of if purchase or sell trade (0 if purchase, 1 if sell)
  uint internalType;

  //dummy trade constructor for testing
  function AbstractTrade(address p, address cp) {
    setFirm(true);
    setStartDate(1,1,1);
    setEndDate(1,1,1);
    setPipe("pipe");
    setCounterParty("counterparty");
    setCounterPartyAddress(cp);
    setParty("party");
    setPartyAddress(p);
    setContact("lee3");
    //setPortfolio("portolio");
    setPricingMethod("pricingmethod");
    setIndex(1,1);
    setIndexFactor(1,1);
    setPoint("point");
    setVolume(1,1);
    setFixedPrice(1,1);
    setComments("comment");
    setTotalVolume(1,1);
    setTotalPrice(1,1);
    owner = msg.sender;
  }

  //real use constructor requiring all required parts of trade
  /*function TradeContract(bool firm, uint startDateM, uint startDateD, uint startDateY, uint endDateM, uint endDateD, uint endDateY, string pipe,
                        string counterParty, address counterPartyAddress, string party, address partyAddress, string contact, string pricingMethod,
                        uint indexP, uint indexS, uint indexFactorP, uint indexFactorS, string point, uint volumeP, uint volumeS, uint fixedPriceD,
                        uint fixedPriceC, string comments, uint totalVolumeP, uint TotalVolumeS) {

                          setFirm(firm);
                          setStartDate(startDateM, startDateD, startDateY);
                          setEndDate(endDateM, endDateD, endDateY);
                          setPipe(pipe);
                          setCounterParty(counterParty);
                          setCounterPartyAdd(counterPartyAddress);
                          setParty(party);
                          setPartyAdd(partyAddress);
                          setContact(contact);
                          setPricingMethod(pricingMethod);
                          setIndex(indexP, indexS);
                          setIndexFactor(indexFactorP, indexFactorS);
                          setPoint(point);
                          setVolume(volumeP, volumeS);
                          setFixedPrice(fixedPriceD, fixedPriceC);
                          setComments(comments);
                          setTotalVolume(totalVolumeP, totalVolumeS);
                        } 
                        */




/***********************************************
                 SET FUNCTIONS                   
************************************************/

  function setFirm(bool f) private {
    firm = f;
  }

  function setStartDate(uint m, uint d, uint y) private {
    startDate.month = m;
    startDate.day = d;
    startDate.year = y;
  }

  function setEndDate(uint m, uint d, uint y) private {
    endDate.month = m;
    endDate.day = d;
    endDate.year = y;
  }

  function setPipe(bytes32 p) private {
    pipe = p;
  }

  function setCounterParty(bytes32 cp) private {
    counterParty = cp;
  }

  function setCounterPartyAddress(address cp) private {
    counterPartyAddress = cp;
  }

  function setParty(bytes32 p) private {
    party = p;
  }

  function setPartyAddress(address p) private {
    partyAddress = p;
  }

  function setContact(bytes32 c) private {
    contact = c;
  }

  function setPricingMethod(bytes32 pm) private {
    pricingMethod = pm;
  }

  function setIndex(uint p, uint s) private {
    index.prefix = p;
    index.suffix = s;
  }

  function setIndexFactor(uint p, uint s) private {
    indexFactor.prefix = p;
    indexFactor.suffix = s;
  }

  function setFixedPrice(uint d, uint c) private {
    fixedPrice.dollars = d;
    fixedPrice.cents = c;
  }

  function setPoint(bytes32 p) private {
    point = p;
  }

  function setVolume(uint p, uint s) private {
    volume.prefix = p;
    volume.suffix = s;
  }

  function setComments(bytes32 c) private {
    comments = c;
  }

  function setTotalVolume(uint p, uint s) private {
    totalVolume.prefix = p;
    totalVolume.suffix = s;
  }

  function setDealDate(uint m, uint d, uint y) private {
    dealDate.month = m;
    dealDate.day = d;
    dealDate.year = y;
  }

  function setTotalPrice(uint d, uint c) private {
    totalPrice.dollars = d;
    totalPrice.cents = c;
  }

  function setTrader(bytes32 t) private {
    trader = t;
  }

  function setEnteredOn(uint m, uint d, uint y) private {
    enteredOn.month = m;
    enteredOn.day = d;
    enteredOn.year = y;
  }


/***********************************************
                 GET FUNCTIONS                   
************************************************/

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

  function getPipe() returns (bytes32 p) {
    require(msg.sender == owner);
    p = pipe;
  }

  function getCounterParty() returns (bytes32 cp) {
    require(msg.sender == owner);
    cp = counterParty;
  }

  function getCounterPartyAddress() returns (address cp) {
    require(msg.sender == owner);
    cp = counterPartyAddress;
  }

  function getParty() returns (bytes32 p) {
    require(msg.sender == owner);
    p = party;
  }

  function getPartyAddress() returns (address p) {
    require(msg.sender == owner);
    p = partyAddress;
  }

  function getContact() returns (bytes32 c) {
    require(msg.sender == owner);
    c = contact;
  }

  function getPricingMethod() returns (bytes32 pm) {
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

  function getPoint() returns (bytes32 p) {
    require(msg.sender == owner);
    p = point;
  }

  function getComments() returns (bytes32 c) {
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

  function getTrader() returns (bytes32 t) {
    require(msg.sender == owner);
    t = trader;
  }

  function getEnteredOn() returns (uint m, uint d, uint y) {
    require(msg.sender == owner);
    m = enteredOn.month;
    d = enteredOn.day;
    y = enteredOn.year;
  }

  //function for the counter party to accept the trade, calls main contract to add trade address to array
  function acceptTrade() payable;
}