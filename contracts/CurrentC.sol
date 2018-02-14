pragma solidity ^0.4.4;
//Copyright © 2018 David Ramirez


/*---------------------------------------------------------------------
                           Main Contract 
-----------------------------------------------------------------------*/
contract CurrentC {

  address owner;
  address[] tradeHistory;
  uint tradeNum;

  //constructor: initializes number of trades for history to 0 and makes the address who deployed contract the owner
  function CurrentC() {
    tradeNum = 0;
    owner = msg.sender;
  }

  //turns the contract into read only
  function terminateContract() {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

  //converts bytes32 type to string, used to read bytes32 type
  function bytes32ToString(bytes32 x) constant returns (string) {
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

  //makes a trade contract between 2 parties and adds to trade history
  function makeTrade(address receiver) payable returns(address tradeContractAddress) {
    address newDeploy =  new TradeContract();//tradeHistory[tradeNum - 1];
    tradeHistory.push(newDeploy);
    tradeNum += 1;
    return newDeploy;
  }

  //returns address of owner of main CCC contract
  function getOwner() returns (address o) {
    o = owner;
  }
  
  //returns current trade num for main contract (ie. the number of trades created (not nec accepted) with main contract)
  function getTradeNum() returns (uint tn) {
    tn = tradeNum;
  }

  //return address of trade contract at trade history index given 
  function getHistory(uint index) returns (address t) {
    if (index <= (tradeNum - 1)) {
      t = tradeHistory[index];
    }
  }

  //returns the party of the trade at given index
  function getTradePartyInfo(uint index) returns (string p/*, address pa, bytes32 cp, address cpa*/) {
    address tradeAdd = tradeHistory[index]; 
    TradeContract tradecontract = TradeContract(tradeAdd);

    bytes32 contractParty = tradecontract.getParty();
    p = bytes32ToString(contractParty);
  }
}









/*---------------------------------------------------------------------
                       Contract for Each Trade
-----------------------------------------------------------------------*/
contract TradeContract {

  //for date type
  struct dateStruct {
    int month;
    int day;
    int year;
  }

  //for price type
  struct priceStruct {
    int dollars;
    int cents;
  }

  //for float type (floats not yet supported by solidity, cannot do math with this struct, set and read only)
  struct decimalNumberStruct {
    int prefix;
    int suffix;
  }

/***********************************************
          MEMBER VARIABLE DECLARATIONS         
************************************************/
  //1  *removed: internal, unneeded
  //bytes32 confirmedBy;
  //dateStruct cDate;

  //2  *removed: internal, unneeded
  //bytes32 actualizedBy;
  //dateStruct aDate;

  //3 *removed: internal, unneeded
  //bool agencyDeal;

  //4 *removed: only one type (gas)
  //bytes32 dealType;

  //5 *removed: internal, unneeded
  //bytes32 term;

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

  address counterPartyAdd;

  //10.b
  bytes32 party;

  address partyAdd;

  //11
  bytes32 contact;

  //12 *removed: internal, unneeded
  //bytes32 portfolio;

  //13
  bytes32 pricingMethod;

  //14 (not sure if this should be an int or a bytes32)
  int index;

  //15
  int indexFactor;

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

  //24 *removed: internal, unneeded
  //bytes32 enteredBy;


  //dummy trade constructor for testing
  function TradeContract() {
    //need to find out from Tim the minimum elements for a contract and put here
    //setConfirmedBy("lee");
    //setCDate(1,1,1);
    //setActualizedBy("lee2");
    //setADate(1,1,1);
    //setAgencyDeal(true);
    //setDealType("dealtype");
    //setTerm("term");
    setFirm(true);
    setStartDate(1,1,1);
    setEndDate(1,1,1);
    setPipe("pipe");
    setCounterParty("counterparty");
    setCounterPartyAdd(0xb29E2bB965eb031ae45b424cD53b072648B7dE02);
    setParty("party");
    setPartyAdd(0x6A10e778F8Ea5F507631585343D5DC190a9Aa09E);
    setContact("lee3");
    //setPortfolio("portolio");
    setPricingMethod("pricingmethod");
    setIndex(1);
    setIndexFactor(1);
    setPoint("point");
    setVolume(1,1);
    setFixedPrice(1,1);
    setComments("comment");
    setTotalVolume(1,1);
  }



/***********************************************
                 SET FUNCTIONS                   
************************************************/
  //removed
  /*function setConfirmedBy(bytes32 cb) {
    confirmedBy = cb;
  }*/

  //removed
  /*function setCDate(int m, int d, int y) {
    cDate.month = m;
    cDate.day = d;
    cDate.year = y;
  }*/

  //removed
  /*function setActualizedBy(bytes32 ab) {
    actualizedBy = ab;
  }*/

  //removed
  /*function setADate(int m, int d, int y) {
    aDate.month = m;
    aDate.day = d;
    aDate.year = y;
  }*/

  //removed
  /*function setAgencyDeal(bool ad) {
    agencyDeal = ad;
  }*/

  //removed
  /*function setDealType(bytes32 dt) {
    dealType = dt;
  }*/

  //removed
  /*function setTerm(bytes32 t) {
    term = t;
  }*/

  function setFirm(bool f) {
    firm = f;
  }

  function setStartDate(int m, int d, int y) {
    startDate.month = m;
    startDate.day = d;
    startDate.year = y;
  }

  function setEndDate(int m, int d, int y) {
    endDate.month = m;
    endDate.day = d;
    endDate.year = y;
  }

  function setPipe(bytes32 p) {
    pipe = p;
  }

  function setCounterParty(bytes32 cp) {
    counterParty = cp;
  }

  function setCounterPartyAdd(address cp) {
    counterPartyAdd = cp;
  }

  function setParty(bytes32 p) {
    party = p;
  }

  function setPartyAdd(address p) {
    partyAdd = p;
  }

  function setContact(bytes32 c) {
    contact = c;
  }

  //removed
  /*function setPortfolio(bytes32 p) {
    portfolio = p;
  }*/

  function setPricingMethod(bytes32 pm) {
    pricingMethod = pm;
  }

  function setIndex(int i) {
    index = i;
  }

  function setIndexFactor(int ir) {
    indexFactor = ir;
  }

  function setFixedPrice(int d, int c) {
    fixedPrice.dollars = d;
    fixedPrice.cents = c;
  }

  function setPoint(bytes32 p) {
    point = p;
  }

  function setVolume(int p, int s) {
    volume.prefix = p;
    volume.suffix = s;
  }

  function setComments(bytes32 c) {
    comments = c;
  }

  function setTotalVolume(int p, int s) {
    totalVolume.prefix = p;
    totalVolume.suffix = s;
  }

  function setDealDate(int m, int d, int y) {
    dealDate.month = m;
    dealDate.day = d;
    dealDate.year = y;
  }

  function setTotalPrice(int d, int c) {
    totalPrice.dollars = d;
    totalPrice.cents = c;
  }

  function setTrader(bytes32 t) {
    trader = t;
  }

  function setEnteredOn(int m, int d, int y) {
    enteredOn.month = m;
    enteredOn.day = d;
    enteredOn.year = y;
  }

  //removed
  /*function setEnteredBy(bytes32 eb) {
    enteredBy = eb;
  }*/



/***********************************************
                 GET FUNCTIONS                   
************************************************/
  //removed
  /*function getConfirmedBy() returns (bytes32 cb) {
    cb = confirmedBy;
  }*/

  //removed
  /*function getCDate() returns (int m, int d, int y) {
    m = cDate.month ;
    d = cDate.day ;
    y =cDate.year;
  }*/

  //removed
  /*function getActualizedBy() returns (bytes32 ab) {
    ab = actualizedBy;
  }*/

  //removed
  /*function getADate() returns (int m, int d, int y) {
    m = aDate.month;
    d = aDate.day;
    y = aDate.year;
  }*/

  //removed
  /*function getAgencyDeal() returns (bool ad) {
    ad = agencyDeal;
  }*/

  //removed
  /*function getDealType() returns (bytes32 dt) {
    dt = dealType;
  }*/

  //removed
  /*function getTerm() returns (bytes32 t) {
    t = term;
  }*/

  function getFirm() returns (bool f) {
    f = firm;
  }

  function getStartDate() returns (int m, int d, int y) {
    m = startDate.month;
    d = startDate.day;
    y = startDate.year;
  }

  function getEndDate() returns (int m, int d, int y) {
    m = endDate.month;
    d = endDate.day;
    y = endDate.year;
  }

  function getPipe() returns (bytes32 p) {
    p = pipe;
  }

  function getCounterParty() returns (bytes32 cp) {
    cp = counterParty;
  }

  function getCounterPartyAdd() returns (address cp) {
    cp = counterPartyAdd;
  }

  function getParty() returns (bytes32 p) {
    p = party;
  }

  function getPartyAdd() returns (address p) {
    p = partyAdd;
  }

  function getContact() returns (bytes32 c) {
    c = contact;
  }

  //removed
  /*function getPortfolio() returns (bytes32 p) {
    p = portfolio;
  }*/

  function getPricingMethod() returns (bytes32 pm) {
    pm = pricingMethod;
  }

  function getIndex() returns (int i) {
    i = index;
  }

  function setIndexFactor() returns (int ir) {
    ir = indexFactor;
  }

  function getFixedPrice() returns (int d, int c) {
    d = fixedPrice.dollars;
    c = fixedPrice.cents;
  }

  function getComments() returns (bytes32 c) {
    c = comments;
  }

  function getTotalVolume() returns (int p, int s) {
    p = totalVolume.prefix;
    s = totalVolume.suffix;
  }

  function getDealDate() returns (int m, int d, int y) {
    m = dealDate.month;
    d = dealDate.day;
    y = dealDate.year;
  }

  function getTotalPrice() returns (int d, int c) {
    d = totalPrice.dollars;
    c = totalPrice.cents;
  }

  function getTrader() returns (bytes32 t) {
    t = trader;
  }

  function getEnteredOn() returns (int m, int d, int y) {
    m = enteredOn.month;
    d = enteredOn.day;
    y = enteredOn.year;
  }

  //removed
  /*function getEnteredBy() returns (bytes32 eb) {
    eb = enteredBy;
  }*/
}