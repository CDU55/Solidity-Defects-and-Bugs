// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract AccidentalTypo {
    int val = 1;

    function decrement() public {
        val =- 1;
    }
}