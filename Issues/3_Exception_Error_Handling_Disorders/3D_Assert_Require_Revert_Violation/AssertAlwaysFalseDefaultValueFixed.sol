// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: The propser comparison operator is used
contract AssertAlwaysFalse{
    
    uint private _limit;
    uint private _currentCount;
    mapping(uint=>address) private _participants;

    constructor(uint limit)
    {
        _limit=limit;
    }

    function register() external
    {
        require(_limit>_currentCount,"The limit has been reached");
        _currentCount+=1;
        _participants[_currentCount]=msg.sender;      
    }
}