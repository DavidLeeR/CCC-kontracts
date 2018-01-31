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

  function getHistory(uint index) returns (address t) {
    if (index <= (tradeNum - 1)){
      t = tradeHistory[index];
    }
  }

  function getTradeInfo(address tradeAdd) returns (string n) {
    TradeContract tradecontract = TradeContract(tradeAdd);
    return tradecontract.getConfirmedBy();
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
  //1 
  string confirmedBy;

  dateStruct cDate;

  //2 
  string actualizedBy;

  dateStruct aDate;

  //3
  bool agencyDeal;

  //4 (storage is labeled "storag" because "storage" is a solidity keyword)
  string dealType;

  //5
  string term;

  //6
  bool firm;

  //7 
  dateStruct startDate;

  //8 
  dateStruct endDate;

  //9 
  string pipe;

  //10
  string counterParty;

  address counterPartyAdd;

  //11
  string contact;

  //12
  string portfolio;

  //13
  string pricingMethod;

  //14 (not sure if this should be an int or a string)
  int index;

  //15
  int indexFactor;

  //16 
  priceStruct fixedPrice;
  //17 (not sure what this parameter is, need to consult Tim)

  //18
  string comments;

  //19 (solidity does not yet support fixed point numbers)
  decimalNumberStruct totalVolume;

  //20
  dateStruct dealDate;

  //21 
  priceStruct totalPrice;

  //22
  string trader;

  //23 (seems to be auto filled in front end, will just get from there instead
  //    of aut filling date here)
  dateStruct enteredOn;

  //24 (seems to be autofilled in front end, get from there)
  string enteredBy;

  //25 (not sure what this parameter is, need to consult Tim)


  function tradeContract() {
    //need to find out from Tim the minimum elements for a contract and put here
    setConfirmedBy("lee");
    setCDate(1,1,1);
    setActualizedBy("lee2");
    setADate(1,1,1);
    setAgencyDeal(true);
    setDealType("dealtype");
    setTerm("term");
    setFirm(true);
    setStartDate(1,1,1);
    setEndDate(1,1,1);
    setPipe("pipe");
    setCounterParty("counterparty");
    setCounterPartyAdd(0xb29e2bb965eb031ae45b424cd53b072648b7de02);
    setContact("lee3");
    setPortfolio("portolio");
    setPricingMethod("pricingmethod");
    setIndex(1);
    setIndexFactor(1);
    setFixedPrice(1,1);
    setComments("comment");
    setTotalVolume(1,1);
  }



/***********************************************
                 SET FUNCTIONS                   
************************************************/
  function setConfirmedBy(string cb) {
    confirmedBy = cb;
  }

  function setCDate(int m, int d, int y) {
    cDate.month = m;
    cDate.day = d;
    cDate.year = y;
  }

  function setActualizedBy(string ab) {
    actualizedBy = ab;
  }

  function setADate(int m, int d, int y) {
    aDate.month = m;
    aDate.day = d;
    aDate.year = y;
  }

  function setAgencyDeal(bool ad) {
    agencyDeal = ad;
  }

  function setDealType(string dt) {
    dealType = dt;
  }

  function setTerm(string t) {
    term = t;
  }

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

  function setPipe(string p) {
    pipe = p;
  }

  function setCounterParty(string cp) {
    counterParty = cp;
  }

  function setCounterPartyAdd(address cp) {
    counterPartyAdd = cp;
  }

  function setContact(string c) {
    contact = c;
  }

  function setPortfolio(string p) {
    portfolio = p;
  }

  function setPricingMethod(string pm) {
    pricingMethod = pm;
  }

  function setIndex(int i) {
    index = i;
  }

  function setIndexFactor(int ir) {
    indexFactor = ir;
  }

  function setFixedPrice(int d, int c){
    fixedPrice.dollars = d;
    fixedPrice.cents = c;
  }

  function setComments(string c) {
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

  function setTrader(string t) {
    trader = t;
  }

  function setEnteredOn(int m, int d, int y) {
    enteredOn.month = m;
    enteredOn.day = d;
    enteredOn.year = y;
  }

  function setEnteredBy(string eb) {
    enteredBy = eb;
  }



/***********************************************
                 GET FUNCTIONS                   
************************************************/
  function getConfirmedBy() returns (string cb) {
    cb = confirmedBy;
  }

  function getCDate() returns (int m, int d, int y) {
    m = cDate.month ;
    d = cDate.day ;
    y =cDate.year;
  }

  function getActualizedBy() returns (string ab) {
    ab = actualizedBy;
  }

  function getADate() returns (int m, int d, int y) {
    m = aDate.month;
    d = aDate.day;
    y = aDate.year;
  }

  function getAgencyDeal() returns (bool ad) {
    ad = agencyDeal;
  }

  function getDealType() returns (string dt) {
    dt = dealType;
  }

  function getTerm() returns (string t) {
    t = term;
  }

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

  function getPipe() returns (string p) {
    p = pipe;
  }

  function getCounterParty() returns (string cp) {
    cp = counterParty;
  }

  function getCounterPartyAdd() returns (address cp) {
    cp = counterPartyAdd;
  }

  function getContact() returns (string c) {
    c = contact;
  }

  function getPortfolio() returns (string p) {
    p = portfolio;
  }

  function getPricingMethod() returns (string pm) {
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

  function getComments() returns (string c) {
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

  function getTrader() returns (string t) {
    t = trader;
  }

  function getEnteredOn() returns (int m, int d, int y) {
    m = enteredOn.month;
    d = enteredOn.day;
    y = enteredOn.year;
  }

  function getEnteredBy() returns (string eb) {
    eb = enteredBy;
  }
}