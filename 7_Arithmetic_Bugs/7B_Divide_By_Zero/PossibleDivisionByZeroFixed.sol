// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Check that the benefactors count is not zero
contract PossibleDivisionByZeroFixed {
   
    uint public benefactorsCount;
    mapping(uint=>address payable) private _benefactors;
    mapping (address=>bool) private _rewardCollected;

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
        _benefactors[benefactorsCount]=benefactor;
    }

    function distributeToBenefactors() external onlyOwner {
        require(benefactorsCount>0);
        uint ammountPerBenefactor=address(this).balance/benefactorsCount;
         for(uint index=1;index<=benefactorsCount;index++)
        {
            if(_rewardCollected[_benefactors[index]])
            {
                continue;
            }
            
            if(_benefactors[index].send(ammountPerBenefactor))
            {
                _rewardCollected[_benefactors[index]]=true;
            }
        }
    }
}