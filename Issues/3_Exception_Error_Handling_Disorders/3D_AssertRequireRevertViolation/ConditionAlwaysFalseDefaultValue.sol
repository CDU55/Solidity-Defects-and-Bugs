// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The register function will never execute because the "require" statement will never pass.
//Since the currentCount variable is not initialized, it will have the default value of 0.
//Having the default value of 0, it will never be higher than another unsigned integer.
//This example presents a simple mistake where the comparison sign is in reverse.
contract ConditionAlwaysFalse {
    uint256 private _limit;
    uint256 private _currentCount;
    mapping(uint256 => address) private _participants;

    constructor(uint256 limit) {
        _limit = limit;
    }

    function register() external {
        require(_limit < _currentCount, "The limit has been reached");
        _currentCount += 1;
        _participants[_currentCount] = msg.sender;
    }
}
