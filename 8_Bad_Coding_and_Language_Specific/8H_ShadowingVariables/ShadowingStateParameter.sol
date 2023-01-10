// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "payDebt" method contains a parameter with the same name as one of the state variables.
contract ShadowingStateParameter{

    uint constant public interest=2;
    mapping(address=>uint) private _indebted;

    constructor() payable{

    }

    function borrow(uint amount) external{
        require(amount<address(this).balance,"Request amount is too high");
        require(_indebted[msg.sender]==0,"You are already indebted");
        _indebted[msg.sender]=amount;
        payable(msg.sender).transfer(amount);
    }

    function payDebt(uint interest) payable external{
        require(_indebted[msg.sender]*interest==msg.value,"Please repay the right amount");
        _indebted[msg.sender]=0;
    }

     function getDebt() external view returns(uint){
        require(_indebted[msg.sender]!=0,"You are not indebted");
        return _indebted[msg.sender];
    }  
}