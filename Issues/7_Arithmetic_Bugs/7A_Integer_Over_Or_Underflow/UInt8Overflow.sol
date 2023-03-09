// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17.0;

contract Overflow {
    uint8 public value;

    constructor (uint8 _value) {
        value = _value;
    }

    function increment() external {
        unchecked {
            value++;            
        }
    }
}