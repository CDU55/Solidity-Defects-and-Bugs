// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the fallback only to emit events.
contract ComplexFallbackFixed {
    address private _owner;
    event newDoner(address doner);

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
        emit newDoner(msg.sender);
    }

    function withdrawFunding() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
