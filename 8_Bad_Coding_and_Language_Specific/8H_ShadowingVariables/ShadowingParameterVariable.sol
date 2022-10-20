// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The "Split" method declares a local variable with the same name as one fo the parameters.
contract ShadowingParameterVariable{

    function split(address[] calldata sendTo,uint amountToSend) external payable{
        require(msg.value>0,'Please also send the currency that is mean to be split');
        require(sendTo.length>0,'Please specify who the currency will be distributed to');
        uint amountToSend=msg.value/sendTo.length;
        for(uint index=0;index<sendTo.length;index++)
        {
            bool success=payable(sendTo[index]).send(amountToSend);
            require(success,'Failed to send currency');
        }
    }
}