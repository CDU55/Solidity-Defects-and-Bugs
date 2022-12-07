// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasCostlyLoop{


    uint[] private companyGrossSalaries;
    constructor(uint[] memory grossSalaries)
    {
        companyGrossSalaries=grossSalaries;
    }

    function getNetSalariesOrdered() external view returns(uint[] memory){
        uint[] memory salaries=new uint[](companyGrossSalaries.length);
        for(uint index=0;index<salaries.length;index++)
        {
            uint salary=companyGrossSalaries[index];
            salary=salary-companyGrossSalaries[index]/100*45;
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