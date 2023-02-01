// SPDX-License-Identifier: MIT
//Fix: Send the Ether in slices.
pragma solidity 0.8.17;

contract DenialOfServiceGasLimit {
    uint256 public benefactorsCount;
    mapping(uint256 => address payable) private _benefactors;
    address private owner;
    uint256 private _lastBenefactorIndex;
    uint256 private _benefactorShare;

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
        _benefactors[benefactorsCount] = benefactor;
    }

    function distributeToBenefactors(uint256 currentSliceCount)
        external
        onlyOwner
    {
        require(benefactorsCount > 0);
        require(_lastBenefactorIndex + currentSliceCount < benefactorsCount);
        if (_benefactorShare == 0) {
            _benefactorShare = address(this).balance / benefactorsCount;
        }
        for (
            uint256 index = _lastBenefactorIndex;
            index < _lastBenefactorIndex + currentSliceCount;
            index++
        ) {
            bool success = _benefactors[index].send(_benefactorShare);
        }
        _lastBenefactorIndex = _lastBenefactorIndex + currentSliceCount;
    }

    function reset() external onlyOwner {
        require(
            _lastBenefactorIndex == benefactorsCount,
            "Not all benefactors received their share"
        );
        _lastBenefactorIndex = 0;
        benefactorsCount = 0;
        _benefactorShare = 0;
    }
}
