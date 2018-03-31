var HDWalletProvider = require("truffle-hdwallet-provider")

var mnemonic = ""


module.exports = {

  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*", // Match any network id
      gas: 8000000
    },
     ropsten:  {
     provider: new HDWalletProvider(mnemonic, "https://ropsten.infura.io/"),
     network_id: 3,
     //host: "localhost",
     //port:  8545,
     gas: 4700000,
     gasPrice: 4000000000
     },
     main:  {
     provider: new HDWalletProvider(mnemonic, "https://mainnet.infura.io/"),
     network_id: 1,
     //host: "localhost",
     //port:  8545,
     gas: 2000000,
     gasPrice: 4000000000
      }
    }
  };


