// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.17;

contract A {
    uint data; // this is by default visible in child contracts

    constructor (uint _data) {
        data = _data;
    }

    function get() external view returns (uint) {
        return data;
    }
}

// contract B is A {

//     constructor (uint _data) A(_data) { }

//     function set(uint alteredData) public {
//         data = alteredData;
//     }
// }