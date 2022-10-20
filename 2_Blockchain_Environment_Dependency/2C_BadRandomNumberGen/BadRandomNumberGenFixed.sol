// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
//Fix: The owner of the contract provides a "salt" value, thus the generated number is not entirely dependent on the block information
contract BlockInfoDependencyFixed {
    uint private contendersCount;
    mapping(uint=>address) private contenders;
    uint private salt;

    address owner;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

      constructor(uint _salt)
    {
        owner=msg.sender;
        contendersCount=0;
        salt=_salt;
    }

    receive() external payable {

    }

    function register(address contender) payable external{
        require(msg.value>=1 ether && msg.value<2 ether,'Invalid entrance tax');
        contenders[contendersCount]=contender;
        contendersCount=contendersCount+1;
    }

    function chooseWinner() external onlyOwner {
        require(contendersCount>10,'Not enough contenders registered');
        uint winnerIndex=(block.number+salt) % contendersCount;
        contendersCount=0;
        payable(contenders[winnerIndex]).transfer(address(this).balance - 1 ether);
        payable(owner).transfer(1 ether);
    }
}