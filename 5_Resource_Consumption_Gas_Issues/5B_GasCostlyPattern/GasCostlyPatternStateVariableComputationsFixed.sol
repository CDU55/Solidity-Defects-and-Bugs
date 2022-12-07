// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasCostlyPatternStateVariableComputations {
  
    uint private averageAPR;

    function computeAPR(uint[] calldata agenciesAPR) external{
        require(agenciesAPR.length>0, 'Please provide the APRs');
        averageAPR=0;
        uint tempAverageAPR=0;
        for(uint index=0;index<agenciesAPR.length;index++)
        {
            tempAverageAPR+=agenciesAPR[index];
        }
        tempAverageAPR=tempAverageAPR/agenciesAPR.length;
        averageAPR=tempAverageAPR;
    }

    function getAPR() external view returns(uint){
        require(averageAPR!=0,'APR not computed yet');
        return averageAPR;
    }

}