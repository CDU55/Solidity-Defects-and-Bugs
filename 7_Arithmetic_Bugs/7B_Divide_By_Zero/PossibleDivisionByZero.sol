// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//This contract contains a divison operation where the divisor is not zero-checked.
//If there are no registered benefactors, the method will fail.
contract PossibleDivisionByZero {
    uint public benefactorsCount;
    mapping(uint=>address payable) private benefactors;

    address owner;

      modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner of the contract can access this");
        _;
    }

      constructor()
    {
        owner=msg.sender;
        benefactorsCount=0;
    }

    receive() external payable {

    }

    function registerBenefactor(address payable benefactor) external{
        benefactorsCount=benefactorsCount+1;
        benefactors[benefactorsCount]=benefactor;
    }

    function distributeToBenefactors() external onlyOwner {
        uint ammountPerBenefactor=address(this).balance/benefactorsCount;
        for(uint index=1;index<=benefactorsCount;index++)
        {
            benefactors[index].transfer(ammountPerBenefactor);
        }

    }
}