// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// The use of "send" (which has a 2300 gas limit) instead of "call" 
// prevents the reentrancy attack.
// However, the ChecksEffectsInteractions pattern is violated
// because the state is modified (effect) after transfer (interaction)
contract ChecksEffectsInteractionsSend {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        bool success = payable(msg.sender).send(addrBal);
        balance[msg.sender] = 0;
        require(success);
    }
}