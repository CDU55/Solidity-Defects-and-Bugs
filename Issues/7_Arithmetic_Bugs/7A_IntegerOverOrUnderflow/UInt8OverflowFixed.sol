// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Overflow {
    uint8 public price;
    address private owner;

    constructor (uint8 initialPrice) {
        price = initialPrice;
        owner = msg.sender;
    }

    function updatePrice(uint8 newPrice) external {
        price = newPrice;
    }
}