// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


//The operator "=+" is used instead of "+="
contract AverageSalary{
    uint private result;
    uint private respondentsCount;
    uint private totalSalary;
    bool private surveyOver;


    function registerSalary(uint salary) external {
        require(!surveyOver,'Ther survey has ended');
        totalSalary=+salary;
        respondentsCount+=1;
    }

    function calculateResult() external returns(uint){
        require(respondentsCount>0,'Nobody has responded yet');
        require(!surveyOver,'Ther survey has ended');
        result=totalSalary/respondentsCount;
        surveyOver=true;
        return result;
    }

    function getResult() external view returns(uint){
        return result;
    }
}