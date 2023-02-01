// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Replace the "assembly" sections with their corresponding Solidity code
contract UseOfAssemblyFixed {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        uint256 toSend = _balance[msg.sender];
        require(_balance[msg.sender] != 0, "No balance found");
        _balance[msg.sender] = 0;
        (bool sent, ) = payable(msg.sender).call{gas: 2300, value: toSend}("");
        require(sent, "Failed to send Ether");
    }
}
