// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Initialize the private variable in the constructor
contract ImproperPrivateVariableInitializationFixed{

    address private owner;
    bool public prizeClaimed;
    uint private secretNumber;
    uint public fee;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner, "Only the owner of the contract can access this");
        _;
    }

    constructor(uint secretNumberParam,uint feeParam) payable
    {
        require(msg.value>feeParam*2,'Must fund the initial prize pool');
        owner=msg.sender;
        secretNumber=secretNumberParam;
        fee=feeParam;
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
}
