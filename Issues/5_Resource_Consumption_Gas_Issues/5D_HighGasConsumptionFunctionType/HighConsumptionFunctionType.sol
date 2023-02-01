// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains a public function that could be declared a external
contract HighConsumptionDataFunctionType {
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

    function transferBalance() public onlyOwner {
        payable(_owner).transfer(address(this).balance);
    }
}
