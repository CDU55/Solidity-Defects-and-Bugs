// SPDX-License-Identifier: MIT
pragma solidity ^0.6.8;

//This contract uses "now" to determine the current time
//Since solidity v 0.7.0, this is deprecated.
contract DeprecatedFunctions {
    mapping(address => uint256) private _applicants;
    uint256 public deadlineTimestamp;

    constructor(uint256 _deadlineTimestamp) public {
        deadlineTimestamp = _deadlineTimestamp;
    }

    function receiveApplication() external {
        require(
            now < deadlineTimestamp,
            "The deadline for applications has been reached"
        );
        _applicants[msg.sender] = 1;
    }
}
