// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a "call" instruction with a hardcoded gas amount, this could produce maintainability issues.
contract HardCodedGasCall{

    mapping(address=>uint) indebted;
    address private _interestCalculator;

    constructor(address interestCalculator) payable{

    }

    function borrow(uint amount) external{
        require(amount<address(this).balance,'Request amount is too high');
        require(indebted[msg.sender]==0,'You are already indebted');
        (bool success, bytes memory result)=_interestCalculator.call{gas: 10000}(abi.encodeWithSignature("calculateInterest(uint,address)", amount, msg.sender));
        require(success,'Cannot calculate interest');
        uint interest = abi.decode(result, (uint));
        indebted[msg.sender]=amount*interest;
        payable(msg.sender).transfer(amount);
    }

    function payDebt() payable external{
        require(indebted[msg.sender]==msg.value,'Please repay the right amount');
        indebted[msg.sender]=0;
    } 
}