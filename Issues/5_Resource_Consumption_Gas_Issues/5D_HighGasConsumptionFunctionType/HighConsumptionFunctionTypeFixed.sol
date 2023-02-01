// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Declare the function as external
contract HighConsumptionDataFunctionTypeFixed {
    address private _owner;

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

    receive() external payable {}

    function transferBalance() external onlyOwner {
        payable(_owner).transfer(address(this).balance);
    }
}
