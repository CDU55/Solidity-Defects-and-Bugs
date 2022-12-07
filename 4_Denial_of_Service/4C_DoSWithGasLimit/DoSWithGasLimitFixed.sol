// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract DenialOfServiceGasLimit {
    uint public benefactorsCount;
    mapping(uint=>address payable) private benefactors;
    mapping (address=>bool) private rewardCollected;
    address private owner;
    uint private lastBenefactorIndex;
    uint private benefactorShare;

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

    function distributeToBenefactors(uint currentSliceCount) external onlyOwner {
        require(benefactorsCount>0);
        require(lastBenefactorIndex+currentSliceCount<benefactorsCount);
        if(benefactorShare==0)
        {
            benefactorShare=address(this).balance/benefactorsCount;
        }
        for(uint index=lastBenefactorIndex;index<lastBenefactorIndex+currentSliceCount;index++)
        {
            bool success=benefactors[index].send(benefactorShare);
        }
        lastBenefactorIndex=lastBenefactorIndex+currentSliceCount;
    }

    function reset() external onlyOwner{
        require(lastBenefactorIndex==benefactorsCount,'Not all benefactors received their share');
        lastBenefactorIndex=0;
        benefactorsCount=0;
        benefactorShare=0;
    }
}