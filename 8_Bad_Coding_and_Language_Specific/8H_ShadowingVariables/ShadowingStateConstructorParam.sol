// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use all state variables that are declared or remove the unused ones
contract ShadowingStateConstructorParam{

    uint private sendToLimit;
    constructor(uint sendToLimit)
    {
        sendToLimit=sendToLimit;
    }
    
    function split(address[] calldata sendTo) external payable{
        require(msg.value>0,'Please also send the currency that is mean to be split');
        require(sendTo.length>0,'Please specify who the currency will be distributed to');
        require(sendTo.length<=sendToLimit,'The maximum amount of receivers has been exceded');
        uint amount=msg.value/sendTo.length;
        for(uint index=0;index<sendTo.length;index++)
        {
            bool success=payable(sendTo[index]).send(amount);
            require(success,'Failed to send currency');
        }
    }
}