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

// even if the limit is sufficient now, in case of an Ethereum upgrade
// that changes the gas costs for some operations, the hardcoded limit 
// might be insufficient
contract HardcodedGasLimit {
    Computer computer;

    constructor (address compAddr) {
        computer = Computer(compAddr);
    }

    function doSomeComputation(uint x) external view returns (uint) {
        return computer.compute{gas: 2000}(x);
    }
}
