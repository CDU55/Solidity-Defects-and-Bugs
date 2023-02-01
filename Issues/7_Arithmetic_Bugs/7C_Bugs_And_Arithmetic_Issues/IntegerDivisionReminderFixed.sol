// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: refund the remaining Ether.
contract IntegerDivisionReminderFixed {
    function split(address[] calldata benefactors) external payable {
        require(benefactors.length > 0, "Please provide a benefactors list");
        uint256 amountPerBenefactor = msg.value / benefactors.length;
        uint256 remainingAmount = msg.value % benefactors.length;
        require(
            amountPerBenefactor > 0,
            "The provided amount must be greater than the benefactors count"
        );
        for (uint256 index = 0; index < benefactors.length; index++) {
            payable(benefactors[index]).transfer(amountPerBenefactor);
        }
        if (remainingAmount > 0) {
            payable(msg.sender).transfer(remainingAmount);
        }
    }
}
