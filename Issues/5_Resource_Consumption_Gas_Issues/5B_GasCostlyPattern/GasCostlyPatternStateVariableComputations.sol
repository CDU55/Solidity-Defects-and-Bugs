// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "computeAPR" method writes "_averageAPR" with each iteration. Since it is a storage variables and writing storage variables is expensive, this is not gas efficient.
contract GasCostlyPatternStateVariableComputations {
  
    uint private _averageAPR;

    function computeAPR(uint[] calldata agenciesAPR) external{
        require(agenciesAPR.length>0, "Please provide the APRs");
        _averageAPR=0;
        for(uint index=0;index<agenciesAPR.length;index++)
        {
            _averageAPR+=agenciesAPR[index];
        }
        _averageAPR=_averageAPR/agenciesAPR.length;
    }

    function getAPR() external view returns(uint){
        require(_averageAPR!=0,"APR not computed yet");
        return _averageAPR;
    }

}