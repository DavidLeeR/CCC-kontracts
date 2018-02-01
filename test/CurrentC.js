var currentc = artifacts.require("./CurrentC.sol");

contract('currentc', function(accounts) {
    it("should create a dummy trade contract", function() {
        var current_c;
        return currentc.deployed().then(function(instance){
            current_c = instance;
        // Get the total guesses
            return current_c.makeTrade.call(0xb29E2bB965eb031ae45b424cD53b072648B7dE02);
        }).then(function(result){
            console.log("new trade contract address =",result.toString());
            return current_c.getHistory.call(0);
        }).then(function(result){
            console.log("address of trade = ", result.toString());
        });
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