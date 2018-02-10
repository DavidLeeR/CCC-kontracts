//Copyright © 2018 David Ramirez

var currentc = artifacts.require("./CurrentC.sol");

contract('currentc', function(accounts) {
    it("should create a dummy trade contract", function() {
        var current_c;
        return currentc.deployed().then(function(instance){
            current_c = instance;
            //make first trade
            current_c.makeTrade(0xb29E2bB965eb031ae45b424cD53b072648B7dE02);
            //get trade history address 1
            return current_c.getHistory.call(0);

        }).then(function(result){
            console.log("new trade contract address =",result);
            //get trade number
            return current_c.getTradeNum.call();

        }).then(function(result){
            console.log("trade number =", result.toNumber());
            //get main contract owner
            return current_c.getTradePartyInfo.call(0);
        }).then(function(result){
            console.log("party info for trade 1 = ", result[0],result[1],result[2],result[3]);
            return current_c.getOwner.call();
        }).then(function(result){
            console.log("main contract owner address = ", result);
            //make second trade
            current_c.makeTrade(0x28744a3CE59A1A2f7fa17e22a3955Ba61558356F);
            //get tradde history address 2 (should be different than address 1)
            return current_c.getHistory.call(1);

        }).then(function(result){
            console.log("2nd new trade contract address =", result);
            return current_c.getTradeNum.call();
        }).then(function(result){
            console.log("trade number after 2nd trade = ", result.toNumber());
        
        });
            /*
            return current_c.getHistory.call(0);
        }).then(function(result){
            console.log("party of trade = ", result.toString());
        });*/
    });
});



/*
    it("should return the party of the trade", function() {
        var current_c;
        return currentc.deployed().then(function(instance){
            current_c = instance;
            return current_c.getHistory.call(0);
        }).then(function(result){
            console.log("trade, sender, receiver address =",result.toString());
        });
    });
  });
  */