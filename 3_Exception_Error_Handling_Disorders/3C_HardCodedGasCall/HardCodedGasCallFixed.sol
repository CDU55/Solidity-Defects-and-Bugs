// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Do not provide a hard coded gas value, make sure that the "call" instruction is not exploited in other ways
contract HardCodedGasCallFixed{

    mapping(address=>uint) indebted;
    address private _interestCalculator;

    constructor(address interestCalculator) payable{

    }

    function borrow(uint amount) external{
        require(amount<address(this).balance,'Request amount is too high');
        require(indebted[msg.sender]==0,'You are already indebted');
        (bool success, bytes memory result)=_interestCalculator.call(abi.encodeWithSignature("calculateInterest(uint,address)", amount, msg.sender));
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