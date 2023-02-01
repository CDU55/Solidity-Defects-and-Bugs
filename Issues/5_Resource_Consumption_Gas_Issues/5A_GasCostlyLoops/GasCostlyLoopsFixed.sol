// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Do not execute the loop inside the contract. Provide a "getter" for each element of the array and one for the size of the array and make the client execute the complex operations.
contract GasCostlyLoopFixed {
    uint256[] private _companyGrossSalaries;

    constructor(uint256[] memory grossSalaries) {
        _companyGrossSalaries = grossSalaries;
    }

    function getSalariesNumber() external view returns (uint256 count) {
        return _companyGrossSalaries.length;
    }

    function getNetSalary(uint256 index)
        external
        view
        returns (uint256 salary)
    {
        require(
            index < _companyGrossSalaries.length,
            "The index that was provided is too high"
        );
        uint256 netSalary = _companyGrossSalaries[index];
        netSalary = salary - (_companyGrossSalaries[index] / 100) * 45;
        return netSalary;
    }
}
