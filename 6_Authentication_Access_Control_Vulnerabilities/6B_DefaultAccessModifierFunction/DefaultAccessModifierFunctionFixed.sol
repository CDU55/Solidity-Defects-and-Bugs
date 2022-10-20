// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13;

//Fix: Specify an access modifier for functions
contract DefaultAccessModifierFunctionFixed{

    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

    constructor() 
    {
        owner=msg.sender;
    }

    receive() external payable { }

    function withdrawDonations(address sentTo) external onlyOwner
    {
        payable(sentTo).transfer(address(this).balance);
    }

}
