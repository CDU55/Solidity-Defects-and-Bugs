// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: A random value is obtained via an oracle without using block.number
// import "https://github.com/provable-things/ethereum-api/blob/master/provableAPI.sol";

// contract BlockInfoDependencyFixed is usingProvable{
contract BlockInfoDependencyFixed {
    uint256 public _contendersCount;
    mapping(uint256 => address) public _contenders;
    address private _owner;
    uint256 public randVal;
    bool public randValSet;
    uint256 constant NUM_RANDOM_BYTES_REQUESTED = 7;

    event LogNewProvableQuery(string description);
    event GeneratedRandom(uint256 v);

    modifier onlyOwner() {
        require(
            msg.sender == _owner,
            "Only the owner of the contract can access this"
        );
        _;
    }

    constructor() {
        _owner = msg.sender;
        _contendersCount = 0;
        randValSet = false;
    }

    receive() external payable {}

    function register() external payable {
        require(
            msg.value >= 1 ether && msg.value < 2 ether,
            "Invalid entrance tax"
        );
        _contenders[_contendersCount] = msg.sender;
        _contendersCount = _contendersCount + 1;
    }

    function provable_newRandomDSQuery(
        uint256 _delay,
        uint256 _nbytes,
        uint256 _customGasLimit
    ) internal returns (bytes32 _queryId) {}

    function provable_randomDS_proofVerify__returnCode(
        bytes32 _queryId,
        string memory _result,
        bytes memory _proof
    ) internal returns (uint8 _returnCode) {}

    function provable_cbAddress()
        public
        pure
        returns (address _callbackAddress)
    {
        return _callbackAddress;
    }

    function getRandomValue() external payable {
        uint256 DELAY = 0;
        uint256 GAS = 200000;
        provable_newRandomDSQuery(DELAY, NUM_RANDOM_BYTES_REQUESTED, GAS);
        emit LogNewProvableQuery("Query sent, waiting response...");
    }

    function __callback(
        bytes32 _queryId,
        string memory _result,
        bytes memory _proof
    ) public {
        require(msg.sender == provable_cbAddress());
        if (
            provable_randomDS_proofVerify__returnCode(
                _queryId,
                _result,
                _proof
            ) != 0
        ) {
            // failed verfication
        } else {
            uint256 ceiling = (256**NUM_RANDOM_BYTES_REQUESTED) - 1;
            randVal = uint256(keccak256(abi.encodePacked(_result))) % ceiling;
            randValSet = true;
            emit GeneratedRandom(randVal);
        }
    }

    function chooseWinner() external onlyOwner {
        require(_contendersCount >= 2, "Not enough contenders registered");
        require(
            randValSet,
            "Random value not retrieved from oracle; call getRandomValue first."
        );
        uint256 winnerIndex = randVal % _contendersCount;
        _contendersCount = 0;
        payable(_contenders[winnerIndex]).transfer(
            address(this).balance - 1 ether
        );
        payable(_owner).transfer(1 ether);
    }
}
