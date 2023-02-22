// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract SendReturnValueNotCheckedHidden {
    mapping (address=>uint) balanceOf;

    function deposit() public payable {
        balanceOf[msg.sender] = msg.value;
    }

    function withdraw() public {
        uint amount = balanceOf[msg.sender];
        bool success  = payable(msg.sender).send(amount);
        success = true; // the return value of send is lost
    }
}