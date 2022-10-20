// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: The propser comparison operator is used
contract AssertAlwaysFalse{
    
    uint private limit;
    uint private currentCount;
    mapping(uint=>address) private participants;

    constructor(uint _limit)
    {
        limit=_limit;
    }

    function register() external
    {
        require(limit>currentCount,'The limit has been reached');
        currentCount+=1;
        participants[currentCount]=msg.sender;
    }
}