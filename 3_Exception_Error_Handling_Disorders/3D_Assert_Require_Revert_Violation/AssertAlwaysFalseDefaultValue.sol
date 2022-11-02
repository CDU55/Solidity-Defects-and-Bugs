// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The register function will never execute because the "require" statement will never pass. Since the currentCount variable is not initialized, it will have the default value of 0
//Having the default value of 0, it will never be higher than another unsigned integer.
//This example presents a simple mistake where the comparison sign is in reverse
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
        require(limit<currentCount,'The limit has been reached');
        currentCount+=1;
        participants[currentCount]=msg.sender;
    }
}