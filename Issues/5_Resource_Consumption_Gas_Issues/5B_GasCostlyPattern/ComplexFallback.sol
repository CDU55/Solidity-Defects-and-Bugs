// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract has a gas costly fallback function. Thus, it will never be able to receive Ether via "transfer" or "send".
//The storage variable assignmed uses too much gas.
contract ComplexFallback {
    address private _owner;
    address private _latestDoner;

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    receive() external payable {
        _latestDoner = msg.sender;
    }

    function withdrawFunding() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function getLatestDoner() external view onlyOwner returns (address) {
        return _latestDoner;
    }
}
