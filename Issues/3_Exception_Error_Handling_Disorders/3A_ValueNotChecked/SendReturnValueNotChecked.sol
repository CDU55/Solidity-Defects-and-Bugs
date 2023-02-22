// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SendReturnValueNotChecked {
    mapping (address=>uint) balanceOf;

    function deposit() public payable {
        balanceOf[msg.sender] = msg.value;
    }

    function withdraw() public {
        uint amount = balanceOf[msg.sender];
        payable(msg.sender).send(amount);
    }
}