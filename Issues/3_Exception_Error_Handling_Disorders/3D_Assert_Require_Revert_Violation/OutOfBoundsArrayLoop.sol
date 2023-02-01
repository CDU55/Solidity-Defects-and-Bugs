// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a loop that will reach an out of bound index in the last iteration because it uses "<=" and the array length for comparison.
contract OutOfBoundsArrayLoop {
    function getArrayMinimum(uint256[] calldata array)
        external
        pure
        returns (uint256)
    {
        uint256 minimum = 2**256 - 1;
        for (uint256 index = 0; index <= array.length; index++) {
            if (minimum > array[index]) {
                minimum = array[index];
            }
        }
        return minimum;
    }
}
