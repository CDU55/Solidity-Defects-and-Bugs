// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The "calculateResult" method declares a local variable with the same name as a state variable.
contract ShadowingStateVariable{
    uint private result;
    uint private respondentsCount;
    uint private totalSalary;
    bool private surveyOver;

    function registerSalary(uint salary) external {
        require(!surveyOver,'Ther survey has ended');
        totalSalary=totalSalary+salary;
        respondentsCount=respondentsCount+1;
    }

    function calculateResult() external returns(uint){
        require(respondentsCount>0,'Nobody has responded yet');
        require(!surveyOver,'Ther survey has ended');
        uint result=totalSalary/respondentsCount;
        surveyOver=true;
        return result;
    }

    function getResult() external view returns(uint){
        return result;
    }
}