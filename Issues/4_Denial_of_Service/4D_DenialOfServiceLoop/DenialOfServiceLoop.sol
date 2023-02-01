// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//This contract contains multiple transfers performed during a loop.
//If the transfer fails due to an out-of-gas exception for any of the iterations, the method cannot execute since it will always stop at the same point in the loop.
contract DenialOfServiceLoop {
    uint256 public benefactorsCount;
    mapping(uint256 => address payable) private benefactors;
    mapping(address => bool) private rewardCollected;
    address private owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        owner = msg.sender;
        benefactorsCount = 0;
    }

    receive() external payable {}

    function registerBenefactor(address payable benefactor) external {
        benefactorsCount = benefactorsCount + 1;
        benefactors[benefactorsCount] = benefactor;
    }

    function distributeToBenefactors() external onlyOwner {
        require(benefactorsCount > 0);
        uint256 ammountPerBenefactor = address(this).balance / benefactorsCount;
        for (uint256 index = 1; index <= benefactorsCount; index++) {
            benefactors[index].transfer(ammountPerBenefactor);
        }
    }
}
