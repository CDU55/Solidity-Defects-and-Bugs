// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Do not execute the loop inside the contract. Provide a "getter" for each element of the array and one for the size of the array and make the client execute the complex operations.
contract GasCostlyLoopFixed{

    uint[] private _companyGrossSalaries;
    constructor(uint[] memory grossSalaries)
    {
        _companyGrossSalaries=grossSalaries;
    }

    function getSalariesNumber() external view returns(uint count)
    {
        return _companyGrossSalaries.length;
    }

    function getNetSalary(uint index) external view returns(uint salary)
    {
        require(index<_companyGrossSalaries.length,"The index that was provided is too high");
        uint netSalary=_companyGrossSalaries[index];
        netSalary=salary-_companyGrossSalaries[index]/100*45;
        return netSalary;
    }

}