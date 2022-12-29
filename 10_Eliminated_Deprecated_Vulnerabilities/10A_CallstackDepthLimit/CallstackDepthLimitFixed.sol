// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ping{
    address private _pong;
    uint private _callLimit;
    uint private _currentCall;
    constructor(address pong,uint callLimit)
    {
        _pong=pong;
        _callLimit=callLimit;
    }

    receive() external payable {
        _currentCall+=1;
        require(_currentCall<=_callLimit,'Call limit reached');
        (bool success,) = payable(_pong).call{value: msg.value}("");
        require(success,'Ping pong failed');
        _currentCall=0;
    }
}

contract Pong{
    address private _ping;
    uint private _callLimit;
    uint private _currentCall;

    constructor(address ping,uint callLimit)
    {
        _ping=ping;
        _callLimit=callLimit;
    }

    receive() external payable {
        _currentCall+=1;
        require(_currentCall<=_callLimit,'Call limit reached');
        (bool success,) = payable(_ping).call{value: msg.value}("");
        require(success,'Ping pong failed');
        _currentCall=0;
    }
}