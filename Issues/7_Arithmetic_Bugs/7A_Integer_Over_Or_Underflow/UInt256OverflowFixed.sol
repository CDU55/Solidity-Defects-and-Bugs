// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17.0;

contract Overflow {
    uint public value;

    constructor (uint _value) {
        value = _value;
    }

    function increment() external {
        require(value + 1 < type(uint).max, "overflow");
        unchecked {
            value++;            
        }
    }
}