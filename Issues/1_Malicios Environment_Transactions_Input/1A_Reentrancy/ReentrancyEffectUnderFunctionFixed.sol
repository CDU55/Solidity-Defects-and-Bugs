// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancyEffectUnderFunctionFixed {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        resetBalanceForAddr(msg.sender);
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        require(success);
    }

    function resetBalanceForAddr(address addr) internal {
        balance[addr] = 0;
    }
}