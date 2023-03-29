// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract ReentrancyEffectUnderFunction {
    mapping(address => uint) private balance;

    function deposit() external payable {
        balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint addrBal = balance[msg.sender];
        (bool success,) = payable(msg.sender).call{value: addrBal}("");
        resetBalanceForAddr(msg.sender);
        require(success);
    }

    function resetBalanceForAddr(address addr) internal {
        balance[addr] = 0;
    }
}