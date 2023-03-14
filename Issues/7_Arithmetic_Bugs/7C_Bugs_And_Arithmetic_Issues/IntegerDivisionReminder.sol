// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract splits an amount of ether between multiple recipients.
//If the provided amount of Ether is not divisible by the recipients count, the remaining Ether will be lost.
contract IntegerDivisionReminder {
    mapping (address => uint) shares;

    function split(address[] calldata recipients) external payable {
        require(recipients.length > 0, "Please provide a recipients list");
        require(msg.value > 0);
        uint256 share = msg.value / recipients.length;
        require(
            share > 0,
            "The provided amount must be greater than the recipients count"
        );
        for (uint256 i = 0; i < recipients.length; i++) {
            shares[recipients[i]] = share;
        }
    }

    function withdraw() external {
        require(shares[msg.sender] > 0);
        payable(msg.sender).transfer(shares[msg.sender]);
    }
}
