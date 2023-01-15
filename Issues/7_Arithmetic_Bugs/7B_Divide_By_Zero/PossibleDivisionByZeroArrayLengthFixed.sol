// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the array of benefactors is not empty
contract PossibleDivisionByZeroArrayLengthFixed{

    function split(address[] calldata benefactors) external payable{
        require(benefactors.length>1,"Please provide 2 or more benefactors");
        require(msg.value>0,"Please provide currency to be split among benefactors");
        uint bounty=msg.value/benefactors.length;
        for(uint index=0;index<benefactors.length;index++)
        {
            (bool success,)=payable(benefactors[index]).call{value:bounty}("");
            require(success,"Could not send ether to benefactors");        
        }
    }
}