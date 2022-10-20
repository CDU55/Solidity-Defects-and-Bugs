// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//The method will never return since there is a contradiction in the require statement, a variable cannot be different from the value that was just assigned to it.
contract AssertAlwaysFalse{
    
    function notGonnaExecute(uint parameter1,uint parameter2) external pure returns(uint)
    {
        uint number=parameter1*parameter2;
        require(number!=parameter1*parameter2);
        return number;
    }
}