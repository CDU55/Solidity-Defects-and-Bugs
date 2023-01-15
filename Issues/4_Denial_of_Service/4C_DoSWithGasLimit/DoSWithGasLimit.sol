// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//Since there is a "send" instruction inside a for loop, there is a high chance that the "distributeBenefactors" method will not receive enough gas to send all Ether to benefactors.
contract DenialOfServiceGasLimit {
    uint public benefactorsCount;
    mapping(uint=>address payable) private _benefactors;
    address private _owner;

      modifier onlyOwner() {
        require(msg.sender == _owner, "Only the owner of the contract can access this");
        _;
    }

      constructor()
    {
        _owner=msg.sender;
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
            bool success=_benefactors[index].send(ammountPerBenefactor);
        }
    }
}