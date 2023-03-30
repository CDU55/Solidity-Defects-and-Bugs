// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Validate the external parameter.
contract OutOfBoundsArrayMinimalFixed {
    uint256[] private _array = [10, 20, 30, 40, 50];

    function getArrayElement(uint256 index) external view returns (uint256) {
        require(
            index < _array.length,
            "Requested array index is greater than the length of the array"
        );
        return _array[index];
    }
}
