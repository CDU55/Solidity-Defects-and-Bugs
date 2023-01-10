// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//Fix: Use a temporary variable to use when computing the APR.
contract GasCostlyPatternStateVariableComputations {
  
    uint private _averageAPR;

    function computeAPR(uint[] calldata agenciesAPR) external{
        require(agenciesAPR.length>0, "Please provide the APRs");
        _averageAPR=0;
        uint tempAverageAPR=0;
        for(uint index=0;index<agenciesAPR.length;index++)
        {
            tempAverageAPR+=agenciesAPR[index];
        }
        tempAverageAPR=tempAverageAPR/agenciesAPR.length;
        _averageAPR=tempAverageAPR;
    }

    function getAPR() external view returns(uint){
        require(_averageAPR!=0,"APR not computed yet");
        return _averageAPR;
    }

}