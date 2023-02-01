// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface LibraryInterface {
    function getInterestRate(
        uint256 amount,
        uint256 startLoan,
        uint256 endLoan
    ) external view returns (uint256);

    function getInterest(
        uint256 amount,
        uint256 startLoan,
        uint256 endLoan
    ) external view returns (uint256);
}

contract UnpredictableStateDynamicLibraries {
    struct Debt {
        uint256 owed;
        uint256 startLoan;
        uint256 endLoan;
        uint256 interestRate;
        bool active;
    }

    mapping(address => Debt) private debters;
    LibraryInterface private _library;

    constructor(address libraryAddress) payable {
        _library = LibraryInterface(libraryAddress);
    }

    function loan(uint256 amount, uint256 duration) external {
        require(!debters[msg.sender].active, "You are already in debt");
        uint256 startLoan = block.timestamp;
        uint256 endLoan = startLoan + duration;
        uint256 interestRate = _library.getInterestRate(
            amount,
            startLoan,
            endLoan
        );
        uint256 interest = _library.getInterest(amount, startLoan, endLoan);
        uint256 owed = amount + interest;
        debters[msg.sender] = Debt(
            owed,
            startLoan,
            endLoan,
            interestRate,
            true
        );
        payable(msg.sender).transfer(amount);
    }
}
