// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HighGasConsumptionDataType {
  
    uint8 private averageAPR;

    function computeAPR(uint8[] calldata agenciesAPR) external{
        require(agenciesAPR.length>0, 'Please provide the APRs');
        averageAPR=0;
        uint8 tempAverageAPR=0;
        for(uint8 index=0;index<agenciesAPR.length;index++)
        {
            tempAverageAPR+=agenciesAPR[index];
        }
        tempAverageAPR=tempAverageAPR/uint8(agenciesAPR.length);
        averageAPR=tempAverageAPR;
    }

    function getAPR() external view returns(uint8){
        require(averageAPR!=0,'APR not computed yet');
        return averageAPR;
    }

}