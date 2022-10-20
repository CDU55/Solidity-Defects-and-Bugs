// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The operator "==" is used instead of "=" for assignation. 
//This produces code that does not affect write the state of the contract in any way, nor does it return a value. Thus, having no effect.
contract DeadCode {
    mapping(address => uint) private participants;

    constructor() 
    {
        participants[msg.sender]=0;
    }

    function deposit(uint option) view external{
        participants[msg.sender] == option;
    }
}