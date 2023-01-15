// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Since these two contracts can call each other infinetly, the callstack depth limit might be reached. 
contract Ping{
    address private _pong;
    constructor(address pong)
    {
        _pong=pong;
    }

    receive() external payable {
        (bool success,) = payable(_pong).call{value: msg.value}("");
        require(success,"Ping pong failed");
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
        require(success,"Ping pong failed");
    }
}