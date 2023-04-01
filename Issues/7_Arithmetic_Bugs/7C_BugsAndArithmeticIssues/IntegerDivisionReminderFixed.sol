// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: refund the remaining Ether.
contract IntegerDivisionReminderFixed {
    mapping (address => uint) shares;
    mapping (address => uint) leftovers;

    function split(address[] calldata recipients) external payable {
        require(recipients.length > 0, "Please provide a recipients list");
        uint256 share = msg.value / recipients.length;
        leftovers[msg.sender] = msg.value % recipients.length;
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

    function withdrawRemaining() external {
        require(leftovers[msg.sender] > 0);
        payable(msg.sender).transfer(leftovers[msg.sender]);
    }
}
