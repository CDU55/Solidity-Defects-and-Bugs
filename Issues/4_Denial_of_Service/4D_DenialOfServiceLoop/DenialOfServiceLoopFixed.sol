// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: Use send instead of transfer and check the value.
contract DenialOfServiceLoopFixed {
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
            if (rewardCollected[benefactors[index]]) {
                continue;
            }

            if (benefactors[index].send(ammountPerBenefactor)) {
                rewardCollected[benefactors[index]] = true;
            }
        }
    }
}
