// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract PossibleDivisionByZeroArrayElement {
    mapping(bool => uint) public values;

    constructor () {
        values[true] = 1;
        values[false] = 0;
    }

    function getSomeResult(uint numerator) external view returns (uint) {
        return numerator / values[false];
    }
}
