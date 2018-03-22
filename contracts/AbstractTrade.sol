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
  address internal owner;
  //6
  bool internal firm;

  //7 
  dateStruct internal startDate;

  //8 
  dateStruct internal endDate;

  //9 
  bytes32 internal pipe;

  //10
  bytes32 internal counterParty;

  address internal counterPartyAddress;

  //10.b
  bytes32 internal party;

  address internal partyAddress;

  //11
  bytes32 internal contact;

  //13
  bytes32 internal pricingMethod;

  //14 
  decimalNumberStruct internal index;

  //15
  decimalNumberStruct internal indexFactor;

  //16 
  priceStruct internal fixedPrice;
  //17 (not sure what this parameter is, need to consult Tim)
  bytes32 internal point;

  decimalNumberStruct internal volume;

  //18
  bytes32 internal comments;

  //19 (solidity does not yet support fixed point numbers)
  decimalNumberStruct internal totalVolume;

  //20
  dateStruct internal dealDate;

  //21 
  priceStruct internal totalPrice;

  //22
  bytes32 internal trader;

  //23 (seems to be auto filled in front end, will just get from there instead
  //    of aut filling date here)
  dateStruct internal enteredOn;

  //keeps track of if purchase or sell trade (0 if purchase, 1 if sell)
  uint internal internalType;

  //dummy trade constructor for testing
  function AbstractTrade(address p, address cp) {
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
    counterPartyAddress = cp;
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

  function setPipe(bytes32 p) public {
    require(msg.sender == partyAddress);
    pipe = p;
  }

  function setCounterParty(bytes32 cp) public {
    require(msg.sender == partyAddress);
    counterParty = cp;
  }

  function setCounterPartyAddress(address cp) public {
    require(msg.sender == partyAddress);
    counterPartyAddress = cp;
  }

  function setParty(bytes32 p) public {
    require(msg.sender == partyAddress);
    party = p;
  }

  function setPartyAddress(address p) public {
    require(msg.sender == partyAddress);
    partyAddress = p;
  }

  function setContact(bytes32 c) public {
    require(msg.sender == partyAddress);
    contact = c;
  }

  function setPricingMethod(bytes32 pm) public {
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

  function setPoint(bytes32 p) public {
    require(msg.sender == partyAddress);
    point = p;
  }

  function setVolume(uint p, uint s) public {
    require(msg.sender == partyAddress);
    volume.prefix = p;
    volume.suffix = s;
  }

  function setComments(bytes32 c) public {
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

  function setTrader(bytes32 t) public {
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