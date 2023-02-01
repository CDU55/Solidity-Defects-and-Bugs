// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract performs an operation on each element of an array. This can be costly if the operation is complex or if the number of elements in the array is large.
contract GasCostlyLoop {
    uint256[] private _companyGrossSalaries;

    constructor(uint256[] memory grossSalaries) {
        _companyGrossSalaries = grossSalaries;
    }

    function getNetSalariesOrdered() external view returns (uint256[] memory) {
        uint256[] memory salaries = new uint256[](_companyGrossSalaries.length);
        for (uint256 index = 0; index < salaries.length; index++) {
            uint256 salary = _companyGrossSalaries[index];
            salary = salary - (_companyGrossSalaries[index] / 100) * 45;
            salaries[index] = salary;
        }
        for (
            uint256 firstIndex = 0;
            firstIndex < salaries.length;
            firstIndex++
        ) {
            for (
                uint256 secondIndex = 0;
                secondIndex < salaries.length;
                secondIndex++
            ) {
                if (salaries[firstIndex] > salaries[secondIndex]) {
                    uint256 temp = salaries[firstIndex];
                    salaries[firstIndex] = salaries[secondIndex];
                    salaries[secondIndex] = temp;
                }
            }
        }
        return salaries;
    }
}
