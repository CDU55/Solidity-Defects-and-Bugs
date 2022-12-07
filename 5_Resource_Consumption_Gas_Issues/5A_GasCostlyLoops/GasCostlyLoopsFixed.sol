// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasCostlyLoopFixed{


    uint[] private companyGrossSalaries;
    constructor(uint[] memory grossSalaries)
    {
        companyGrossSalaries=grossSalaries;
    }

    function getSalariesNumber() external view returns(uint count)
    {
        return companyGrossSalaries.length;
    }

    function getNetSalary(uint index) external view returns(uint salary)
    {
        require(index<companyGrossSalaries.length,'The index that was provided is too high');
        uint netSalary=companyGrossSalaries[index];
        netSalary=salary-companyGrossSalaries[index]/100*45;
        return netSalary;
    }

}