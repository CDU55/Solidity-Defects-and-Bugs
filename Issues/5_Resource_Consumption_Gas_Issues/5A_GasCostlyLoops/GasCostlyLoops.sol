// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
//This contract performs an operation on each element of an array. This can be costly if the operation is complex or if the number of elements in the array is large.
contract GasCostlyLoop{

    uint[] private _companyGrossSalaries;
    constructor(uint[] memory grossSalaries)
    {
        _companyGrossSalaries=grossSalaries;
    }

    function getNetSalariesOrdered() external view returns(uint[] memory){
        uint[] memory salaries=new uint[](_companyGrossSalaries.length);
        for(uint index=0;index<salaries.length;index++)
        {
            uint salary=_companyGrossSalaries[index];
            salary=salary-_companyGrossSalaries[index]/100*45;
            salaries[index]=salary;
        }
        for(uint firstIndex=0;firstIndex<salaries.length;firstIndex++)
        {
            for(uint secondIndex=0;secondIndex<salaries.length;secondIndex++)
            {
                if(salaries[firstIndex]>salaries[secondIndex])
                {
                    uint temp=salaries[firstIndex];
                    salaries[firstIndex]=salaries[secondIndex];
                    salaries[secondIndex]=temp;
                }
            }
        }
        return salaries;
    }

}