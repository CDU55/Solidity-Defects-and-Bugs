// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Do not use local variables with the same name as the state variables.
contract ShadowingStateVariableFixed {
    uint256 private _result;
    uint256 private _respondentsCount;
    uint256 private _totalSalary;
    bool private _surveyOver;

    function registerSalary(uint256 salary) external {
        require(!_surveyOver, "Ther survey has ended");
        _totalSalary = _totalSalary + salary;
        _respondentsCount = _respondentsCount + 1;
    }

    function calculateResult() external returns (uint256) {
        require(_respondentsCount > 0, "Nobody has responded yet");
        require(!_surveyOver, "Ther survey has ended");
        _result = _totalSalary / _respondentsCount;
        _surveyOver = true;
        return _result;
    }

    function getResult() external view returns (uint256) {
        return _result;
    }
}
