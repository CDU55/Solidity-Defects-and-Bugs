// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Ping{
    address private _pong;
    constructor(address pong)
    {
        _pong=pong;
    }

    receive() external payable {
        (bool success,) = payable(_pong).call{value: msg.value}("");
        require(success,'Ping pong failed');
    }
}

contract Pong{
    address private _ping;
    constructor(address ping)
    {
        _ping=ping;
    }

    receive() external payable {
        (bool success,) = payable(_ping).call{value: msg.value}("");
        require(success,'Ping pong failed');
    }
}