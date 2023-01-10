// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use "send" instead of "call" to prevent reentrancy. The imposed gas limit of the instruction will not allow a reentrancy attack.
contract ReentrancyDAOFixedSend {

    mapping(address => uint) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(_balance[msg.sender]!=0,"No balance found");
        uint toSend=_balance[msg.sender];
        bool success=payable(msg.sender).send(toSend);
        require(success,"Could not send ether");
        _balance[msg.sender]=0;
    }
}