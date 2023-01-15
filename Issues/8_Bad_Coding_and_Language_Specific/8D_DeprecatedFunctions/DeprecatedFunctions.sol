// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

//This contract uses "now" to determine the current time
//Since solidity v 0.7.0, this is deprecated.
contract DeprecatedFunctions {
    mapping(address => uint) private _applicants;
    uint public deadlineTimestamp;

    constructor(uint _deadlineTimestamp) public
    {
        deadlineTimestamp=_deadlineTimestamp;
    }

    function receiveApplication() external{
        require(now<deadlineTimestamp,"The deadline for applications has been reached");
        _applicants[msg.sender]=1;
    }
}