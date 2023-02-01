// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract splits an amount of ether between multiple benefactors.
//If the provided amount of Ether is not divisible by the benefactors count, the remaining Ether will be lost.
contract IntegerDivisionReminder {
    function split(address[] calldata benefactors) external payable {
        require(benefactors.length > 0, "Please provide a benefactors list");
        uint256 amountPerBenefactor = msg.value / benefactors.length;
        require(
            amountPerBenefactor > 0,
            "The provided amount must be greater than the benefactors count"
        );
        for (uint256 index = 0; index < benefactors.length; index++) {
            payable(benefactors[index]).transfer(amountPerBenefactor);
        }
    }
}
