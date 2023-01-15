// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use an alternative to the deprecated function
contract DeprecatedFunctionsFixed {
    mapping(address => uint) private _applicants;
    uint public deadlineTimestamp;
    constructor(uint _deadlineTimestamp)
    {
        deadlineTimestamp=_deadlineTimestamp;
    }

    function receiveApplication() external{
        require(block.timestamp<deadlineTimestamp,"The deadline for applications has been reached");
        _applicants[msg.sender]=1;
    }
}