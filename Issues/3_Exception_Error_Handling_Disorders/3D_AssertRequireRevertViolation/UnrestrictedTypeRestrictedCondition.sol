// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// the condition in require makes sense, but x could be an uint instead
// otherwise, the caller could send values that will revert the transactions
// it is desirable to use the right type for x (uint instead of int)
contract UnrestrictedTypeRestrictedCondition {
    function squareRoot(int x) public pure returns (uint) {
        require(0 <= x); 
        if (x == 0) {
            return 0;
        }
        uint y = 0;
        while ((y + 1) * (y + 1) <= uint(x)) {
            y = y + 1;
        }

        return y;
    }
}