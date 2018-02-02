pragma solidity ^0.4.4;



/*---------------------------------------------------------------------
                           Main Contract 
-----------------------------------------------------------------------*/
contract CurrentC {

  address owner;
  address[] tradeHistory;
  uint tradeNum;

  function CurrentC() {
    tradeNum = 0;
    owner = msg.sender;
  }

  function suicide() {
    if (msg.sender == owner) {
      selfdestruct(owner);
    }
  }

  function makeTrade(address receiver) payable returns(address tradeContractAddress) {
    address newDeploy =  new TradeContract();//tradeHistory[tradeNum - 1];
    tradeHistory.push(newDeploy);
    tradeNum += 1;
    return newDeploy;
  }

  function getOwner() returns (address o) {
    o = owner;
  }
  function getTradeNum() returns (uint tn) {
    tn = tradeNum;
  }

  function getHistory(uint index) returns (address t) {
    if (index <= (tradeNum - 1)) {
      t = tradeHistory[index];
    }
  }

  function getTradeInfo(uint index) returns (bytes32 n) {
    address tradeAdd = tradeHistory[index]; 
    TradeContract tradecontract = TradeContract(tradeAdd);
    n = tradecontract.getParty();
  }
}









/*---------------------------------------------------------------------
                       Contract for Each Trade
-----------------------------------------------------------------------*/
contract TradeContract {


  struct dateStruct {
    int month;
    int day;
    int year;
  }

  struct priceStruct {
    int dollars;
    int cents;
  }

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



  function tradeContract() {
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