// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract BlockhashDependency {
    uint private contendersCount;
    mapping(uint=>address) private contenders;

    address owner;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

      constructor()
    {
        owner=msg.sender;
        contendersCount=0;
    }

    receive() external payable {

    }

    function register(address contender) payable external{
        require(msg.value>=1 ether && msg.value<2 ether,"Invalid entrance tax");
        contenders[contendersCount]=contender;
        contendersCount=contendersCount+1;
    }

    function chooseWinner() external onlyOwner {
        require(contendersCount>10,"Not enough contenders registered");
        uint winnerIndex=uint(blockhash(block.number)) % contendersCount;
        contendersCount=0;
        payable(contenders[winnerIndex]).transfer(address(this).balance - 1 ether);
        payable(owner).transfer(1 ether);
    }
}