// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// The use of "transfer" (which has a gas limit) instead of "call" 
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
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(addrBal);
    }
}