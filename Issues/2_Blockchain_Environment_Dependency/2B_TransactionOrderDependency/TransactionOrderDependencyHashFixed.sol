// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract TransactionOrderDependencyHash {
    bytes32 constant TO_GUESS = 0x3350d745acd40b6a232b0266fe40c74a81ac78c31f48c00f5714ba6769cbc374;
    bytes32 public locked = 0x00;
    uint private prize;
    uint commitTime = 0;

    constructor() payable {
        prize = msg.value;
    }

    function guess(bytes memory g) public {
        bytes memory pack = abi.encodePacked(g, msg.sender);
        require(keccak256(pack) == locked);
        if (keccak256(g) == TO_GUESS) {
            payable(msg.sender).transfer(prize);
        }
    }

    function commit(bytes32 locked_g) public {
        require(locked == locked_g);
        locked = locked_g;
        commitTime = block.timestamp;
    }

    function release() public {
        require(commitTime > block.timestamp + 7200);
        locked = 0x00;
    }
}