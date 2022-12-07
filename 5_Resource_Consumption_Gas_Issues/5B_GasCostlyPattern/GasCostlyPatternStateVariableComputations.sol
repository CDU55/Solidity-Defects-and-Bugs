// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//To implement and example using a struct containing 4 uints and/or an array of length 1
contract GasCostlyPatternStateVariableComputations {
  
    uint private averageAPR;

    function computeAPR(uint[] calldata agenciesAPR) external{
        require(agenciesAPR.length>0, 'Please provide the APRs');
        averageAPR=0;
        for(uint index=0;index<agenciesAPR.length;index++)
        {
            averageAPR+=agenciesAPR[index];
        }
        averageAPR=averageAPR/agenciesAPR.length;
    }

    function getAPR() external view returns(uint){
        require(averageAPR!=0,'APR not computed yet');
        return averageAPR;
    }

}