// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract UnexpectedThrowOrRevert {
    address[] private bidders;
    uint256[] private bids;
    uint private len;
    address owner;

    constructor () {
        owner = msg.sender;
        len = 0;
    }

    function bid() external payable {
        if (len == 0) {
            bids[len] = msg.value;
            bidders[len] = msg.sender;
            len = len + 1;
        } else if (msg.value > bids[len - 1]) {
            bids[len] = msg.value;
            bidders[len] = msg.sender;
            len = len + 1;
        } else {
            revert("the bid is lower than the current highest bid");
        }
    }

    function close() external {
        require(owner == msg.sender); // onlyOwner
        for (uint i = 0; i < len; i++) { // arbitrary len is bad anyway
            // a single failure will block all funds 
            assert(payable(bidders[i]).send(bids[i]));
        }
    }
}
