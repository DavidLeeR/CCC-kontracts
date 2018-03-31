pragma solidity ^0.4.19;
//Copyright © 2018 David Ramirez

import "./AbstractTrade.sol";
import "./CurrentC.sol";

/*---------------------------------------------------------------------
                       Contract for Each Sell Trade
-----------------------------------------------------------------------*/
contract SellTradeContract is AbstractTrade {

  //dummy trade constructor for testing 
  function SellTradeContract(address p, address cp) AbstractTrade(p, cp) {
    internalType = 1;
  }

  //function for the counter party to accept the trade, calls main contract to add trade address to array
  function acceptTrade() payable {
    //caller of this function must be the counter party
    require(msg.sender == counterPartyAddress);
    address mainInterfaceAddress = owner; 
    CurrentC currentc = CurrentC(mainInterfaceAddress);

    currentc.acceptTradeMain();

    //makes contract read only, sending all funds it contains to the party 
    selfdestruct(partyAddress);
  }

  function declineTrade() {
    require(msg.sender == counterPartyAddress);

    address mainInterfaceAddress = owner; 
    CurrentC currentc = CurrentC(mainInterfaceAddress);

    currentc.declineTradeMain();

    //makes contract read only, sending all funds it contains to the party
    selfdestruct(partyAddress);
  }

}
