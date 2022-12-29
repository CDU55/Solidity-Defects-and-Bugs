// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ErroneousConstructorNanme{

    address private owner;
    bool public prizeClaimed;
    uint private secretNumber;
    uint public fee;
    bool private initialized;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner, "Only the owner of the contract can access this");
        _;
    }

    function initialize(uint _secretNumber,uint _fee) external payable {
        require(msg.value>_fee*2,'Must fund the initial prize pool');
        require(!initialized,'The contract has already beeen initialized');
        owner=msg.sender;
        secretNumber=_secretNumber;
        fee=_fee;
    }

    receive() external payable { }

    function guessTheNumber(uint option) notOwner external payable{
        require(msg.value==fee,'You must');
        require(option > 0,'Option should be between 1 and 10');
        require(option<=10,'Option should be between 1 and 10');
        require(!prizeClaimed,'The prize has already been claimed, plese wait for the secret number reset');
        if(secretNumber==option)
        {
            require(address(this).balance>fee*2,'Insuficient funds to receive prize');
            prizeClaimed=true;
            payable(msg.sender).transfer(msg.value*2);
        }
    }

    function retrieveEarnings( ) onlyOwner external payable {
        require(prizeClaimed,'The prize has not yet been claimed');
        payable(msg.sender).transfer(address(this).balance);
    }

    function resetNumber(uint number) onlyOwner external payable {
        require(msg.value>fee*2,'Resseting the number must also replenish the prize fund');
        secretNumber=number;
        prizeClaimed=false;
    }
}
