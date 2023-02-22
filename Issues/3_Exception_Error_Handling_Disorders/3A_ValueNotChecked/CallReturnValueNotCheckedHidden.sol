// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract CallReturnValueNotCheckedHidden {
    mapping (address=>uint) balanceOf;

    function deposit() public payable {
        balanceOf[msg.sender] = msg.value;
    }

    function withdraw() public {
        uint amount = balanceOf[msg.sender];
        (bool success,)  = payable(msg.sender).call{value: amount}("");
        success = true; // the return value of call is lost
    }
}