// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//Fix: The owner of the contract provides a "salt" value, thus the generated number is not entirely dependent on the block information
contract BlockInfoDependencyFixed {

    uint private _contendersCount;
    mapping(uint=>address) private _contenders;
    uint private _salt;
    address private _owner;

      modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner of the contract can access this");
        _;
    }

      constructor(uint salt)
    {
        _owner=msg.sender;
        _contendersCount=0;
        _salt=salt;
    }

    receive() external payable {

    }

    function register(address contender) payable external{
        require(msg.value>=1 ether && msg.value<2 ether,"Invalid entrance tax");
        _contenders[_contendersCount]=contender;
        _contendersCount=_contendersCount+1;
    }

    function chooseWinner() external onlyOwner {
        require(_contendersCount>10,"Not enough contenders registered");
        uint winnerIndex=(block.number+_salt) % _contendersCount;
        _contendersCount=0;
        payable(_contenders[winnerIndex]).transfer(address(this).balance - 1 ether);
        payable(_owner).transfer(1 ether);
    }
}