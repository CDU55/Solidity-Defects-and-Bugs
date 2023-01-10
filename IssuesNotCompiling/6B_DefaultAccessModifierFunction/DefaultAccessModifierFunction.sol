// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The default access modifier is used for the "whithdrawDonations" functions. It will be public by default, which was not the intent
contract DefaultAccessModifierFunction{

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

    function withdrawDonations(address sentTo)
    {
        payable(sentTo).transfer(address(this).balance);
    }

}
