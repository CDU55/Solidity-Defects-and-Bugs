// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//Fix: Check that the benefactors count is not zero
contract PossibleDivisionByZeroFixed {
    uint public benefactorsCount;
    mapping(uint=>address payable) private benefactors;
    mapping (address=>bool) private rewardCollected;

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
        require(benefactorsCount>0);
        uint ammountPerBenefactor=address(this).balance/benefactorsCount;
         for(uint index=1;index<=benefactorsCount;index++)
        {
            if(rewardCollected[benefactors[index]])
            {
                continue;
            }
            
            if(benefactors[index].send(ammountPerBenefactor))
            {
                rewardCollected[benefactors[index]]=true;
            }
        }
    }
}