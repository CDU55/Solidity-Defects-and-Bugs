// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Use the "=" operator as was the intent do perform an assignation.
contract DeadCodeFIxed {
    mapping(address => uint) private participants;

    constructor()
    {
        participants[msg.sender]=0;
    }

    function deposit(uint option) external{
        participants[msg.sender] = option;
    }
}