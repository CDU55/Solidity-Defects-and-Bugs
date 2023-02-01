// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//The "transfer" method might receive less bytes than expected and Solidity will pad the missing space with zeros.
contract ShortAddress {
    mapping(address => uint256) private _balance;

    function deposit() external payable {
        _balance[msg.sender] = msg.value;
    }

    function withdraw() external {
        require(_balance[msg.sender] != 0, "No balance found");
        uint256 toSend = _balance[msg.sender];
        payable(msg.sender).transfer(toSend);
        _balance[msg.sender] = 0;
    }

    function transfer(address to, uint256 value) external {
        require(
            _balance[msg.sender] >= value,
            "Your balance is smaller than the transfer value"
        );
        payable(to).transfer(value);
    }
}
