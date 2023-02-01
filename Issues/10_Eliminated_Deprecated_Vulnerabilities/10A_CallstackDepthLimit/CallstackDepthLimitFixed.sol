// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check the number of current calls.
contract Ping {
    address private _pong;
    uint256 private _callLimit;
    uint256 private _currentCall;

    constructor(address pong, uint256 callLimit) {
        _pong = pong;
        _callLimit = callLimit;
    }

    receive() external payable {
        _currentCall += 1;
        require(_currentCall <= _callLimit, "Call limit reached");
        (bool success, ) = payable(_pong).call{value: msg.value}("");
        require(success, "Ping pong failed");
        _currentCall = 0;
    }
}

contract Pong {
    address private _ping;
    uint256 private _callLimit;
    uint256 private _currentCall;

    constructor(address ping, uint256 callLimit) {
        _ping = ping;
        _callLimit = callLimit;
    }

    receive() external payable {
        _currentCall += 1;
        require(_currentCall <= _callLimit, "Call limit reached");
        (bool success, ) = payable(_ping).call{value: msg.value}("");
        require(success, "Ping pong failed");
        _currentCall = 0;
    }
}
