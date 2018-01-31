var currentc = artifacts.require("./CurrentC.sol");

contract('currentc', function(accounts) {
    it("should create a dummy trade contract", function() {
        var current_c;
        return currentc.deployed().then(function(instance){
            current_c = instance;
        // Get the total guesses
            return current_c.makeTrade.call(0xb29e2bb965eb031ae45b424cd53b072648b7de02);
        }).then(function(result){
            console.log("new trade contract address =",result.toString());
        });
    });
   // it("should return the address of the contract, sender, and receiver", function() {
   //     var current_c;
   //     return currentc.deployed().then(function(instance){
   //         current_c = instance;
   //         return current_c.getHistory.call(0);
   //     }).then(function(result){
   //         console.log("trade, sender, receiver address =",result.toString());
   //     });
   // });
  });