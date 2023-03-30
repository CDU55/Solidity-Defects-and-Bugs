// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// fix: change the parameter type to uint
contract UnrestrictedTypeRestrictedCondition {
    function squareRoot(uint x) public pure returns (uint) {
        if (x == 0) {
            return 0;
        }
        uint y = 0;
        while ((y + 1) * (y + 1) <= x) {
            y = y + 1;
        }

        return y;
    }
}