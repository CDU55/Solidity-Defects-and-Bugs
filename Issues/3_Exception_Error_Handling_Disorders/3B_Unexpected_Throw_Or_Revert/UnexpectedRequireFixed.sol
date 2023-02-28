// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract UnexpectedThrowOrRevert {
    mapping(address => uint) bids;
    address maxBidder;
    address owner;

    constructor () {
        owner = msg.sender;
    }

    function bid() external payable {
        bids[msg.sender] = msg.value;
        if (msg.value > bids[maxBidder]) {
            maxBidder = msg.sender;
        }
    }

    function withdraw() external {
        require(bids[msg.sender] > 0);
        bids[msg.sender] = 0;
        require(payable(msg.sender).send(bids[msg.sender]));
    }
}
