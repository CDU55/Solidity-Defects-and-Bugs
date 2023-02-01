// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Using an uint8 rather than an uint(uint256) can be more costly in some cases since the EVM performs a downscale operations on a normal uint to make it uint8
contract HighGasConsumptionDataType {
    uint8 private _averageAPR;

    function computeAPR(uint8[] calldata agenciesAPR) external {
        require(agenciesAPR.length > 0, "Please provide the APRs");
        _averageAPR = 0;
        uint8 tempAverageAPR = 0;
        for (uint8 index = 0; index < agenciesAPR.length; index++) {
            tempAverageAPR += agenciesAPR[index];
        }
        tempAverageAPR = tempAverageAPR / uint8(agenciesAPR.length);
        _averageAPR = tempAverageAPR;
    }

    function getAPR() external view returns (uint8) {
        require(_averageAPR != 0, "APR not computed yet");
        return _averageAPR;
    }
}
