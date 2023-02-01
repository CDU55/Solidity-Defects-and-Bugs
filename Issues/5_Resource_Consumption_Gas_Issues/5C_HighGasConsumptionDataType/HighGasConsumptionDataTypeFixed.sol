// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use the default uint if we are only using one uint8 in that memory location.
contract HighGasConsumptionDataTypeFixed {
    uint256 private _averageAPR;

    function computeAPR(uint8[] calldata agenciesAPR) external {
        require(agenciesAPR.length > 0, "Please provide the APRs");
        _averageAPR = 0;
        uint256 tempAverageAPR = 0;
        for (uint256 index = 0; index < agenciesAPR.length; index++) {
            tempAverageAPR += agenciesAPR[index];
        }
        tempAverageAPR = tempAverageAPR / agenciesAPR.length;
        _averageAPR = tempAverageAPR;
    }

    function getAPR() external view returns (uint256) {
        require(_averageAPR != 0, "APR not computed yet");
        return _averageAPR;
    }
}
