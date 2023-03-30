// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: The proper comparison operator is used
contract ConditionAlwaysFalse {
    uint256 private _limit;
    uint256 private _currentCount;
    mapping(uint256 => address) private _participants;

    constructor(uint256 limit) {
        _limit = limit;
    }

    function register() external {
        require(_limit > _currentCount, "The limit has been reached");
        _currentCount += 1;
        _participants[_currentCount] = msg.sender;
    }
}
