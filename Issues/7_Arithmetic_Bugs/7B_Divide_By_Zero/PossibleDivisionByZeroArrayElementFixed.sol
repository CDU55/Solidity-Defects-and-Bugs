// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract PossibleDivisionByZeroArrayElement {
    uint[] public values;

    constructor () {
        values = [1,2,3,0,5];
    }

    function getSomeResult(uint numerator) external view returns (uint) {
        return numerator / values[2];
    }
}
