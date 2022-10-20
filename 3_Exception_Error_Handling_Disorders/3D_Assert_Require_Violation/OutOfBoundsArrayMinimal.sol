// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The "getArrayElement" return an element from the array using an unverified external parameter. This index could be out of bounds.
contract OutOfBoundsArrayMinimal {

    uint256[] private array= [10, 20, 30, 40, 50]; 

    function getArrayElement(uint256 index) external view returns (uint256) {
        return array[index];
    }

}