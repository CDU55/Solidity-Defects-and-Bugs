// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Computer {
    function compute(uint input) external pure returns (uint) {
        uint x = input;
        x = x * x;
        x = x / x;
        x = x + 1;
        return x;
    }
}

// fix: use gasleft()
contract HardcodedGasLimit {
    Computer computer;

    constructor (address compAddr) {
        computer = Computer(compAddr);
    }

    function doSomeComputation(uint x) external view returns (uint) {
        return computer.compute{gas: gasleft()}(x);
    }
}
