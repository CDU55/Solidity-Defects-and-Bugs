// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract TransactionOrderDependencyHash {
    bytes32 constant TO_GUESS = 0x3350d745acd40b6a232b0266fe40c74a81ac78c31f48c00f5714ba6769cbc374;
    uint private prize;

    constructor() payable {
        prize = msg.value;
    }

    function guess(bytes memory g) public {
        if (keccak256(g) == TO_GUESS) {
            payable(msg.sender).transfer(prize);
        }
    }
}