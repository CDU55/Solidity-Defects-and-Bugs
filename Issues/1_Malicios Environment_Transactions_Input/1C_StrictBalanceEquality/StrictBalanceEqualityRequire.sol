// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StrictBalanceEqualityToken {
    address private owner;
    mapping(address => uint) public balance;
    uint private tokenPrice;
    uint private availableSupply;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor(uint _tokenPrice, uint _availableSupply) {
        owner = msg.sender;
        tokenPrice = _tokenPrice;
        availableSupply = _availableSupply;
    }

   function buy(uint amount) external payable {
       require(amount <= availableSupply);
       require(amount * tokenPrice <= msg.value);
       if (amount * tokenPrice == msg.value) {
           balance[msg.sender] += amount;
           availableSupply -= amount;
       } // lost funds if amount * tokenPrice < msg.value
   }

   function withdraw() public onlyOwner {
       payable(owner).transfer(address(this).balance);
   }
}
