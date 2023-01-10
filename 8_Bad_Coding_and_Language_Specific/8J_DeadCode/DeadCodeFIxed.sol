// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the "=" operator as was the intent do perform an assignation.
contract DeadCodeFIxed {
    mapping(address => uint) private _participants;

    constructor()
    {
        _participants[msg.sender]=0;
    }

    function deposit(uint option) external{
        _participants[msg.sender] = option;
    }
}