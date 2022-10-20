// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a divison operation where the divisor is not zero-checked.
//If there are no benefactors provided, the method will fail.
contract PossibleDivisionByZeroArrayLength{

    function split(address[] calldata benefactors) external payable{
        require(msg.value>0,'Please provide currency to be split among benefactors');
        uint bounty=msg.value/benefactors.length;
        for(uint index=0;index<benefactors.length;index++)
        {
            (bool success,)=payable(benefactors[index]).call{value:bounty}("");
            require(success,'Could not send ether to benefactors');        
        }
    }
}