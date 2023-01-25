// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

//Fix: A random value is obtained via an oracle without using blockhash
// import "https://github.com/provable-things/ethereum-api/blob/master/provableAPI.sol";

// contract BlockInfoDependencyFixed is usingProvable{
contract BlockhashDependency {
   uint public _contendersCount;
  mapping(uint=>address) public _contenders;
  address private _owner;
  uint public randVal;
  bool public randValSet;
  uint256 constant NUM_RANDOM_BYTES_REQUESTED = 7;

  event LogNewProvableQuery(string description);
  event GeneratedRandom(uint v);

  modifier onlyOwner() {
    require(msg.sender == _owner, "Only the owner of the contract can access this");
    _;
  }
  
  constructor() {
      _owner = msg.sender;
      _contendersCount = 0;
      randValSet = false;
    }
  
  receive() external payable {
    
  }
  
  function register() payable external{
    require(msg.value >= 1 ether && msg.value < 2 ether,"Invalid entrance tax");
    _contenders[_contendersCount] = msg.sender;
    _contendersCount = _contendersCount+1;
  }

  function provable_newRandomDSQuery(uint _delay, uint _nbytes, uint _customGasLimit) internal returns (bytes32 _queryId) {
  }

  function provable_randomDS_proofVerify__returnCode(bytes32 _queryId, string memory _result, bytes memory _proof) internal returns (uint8 _returnCode) {
  }

  function provable_cbAddress() pure public returns (address _callbackAddress) {
      return _callbackAddress;
  }

  function getRandomValue() external payable {
    uint DELAY = 0;
    uint GAS = 200000;
    provable_newRandomDSQuery(DELAY, NUM_RANDOM_BYTES_REQUESTED, GAS);
    emit LogNewProvableQuery("Query sent, waiting response...");
  }

  function __callback(bytes32 _queryId,
		      string memory _result,
		      bytes memory _proof)
    public
  {
    require(msg.sender == provable_cbAddress());
    if (provable_randomDS_proofVerify__returnCode(_queryId, _result, _proof) != 0) {
      // failed verfication
    } else {
      uint ceiling = (256 ** NUM_RANDOM_BYTES_REQUESTED) - 1;
      randVal = uint(keccak256(abi.encodePacked(_result))) % ceiling;
      randValSet = true;
      emit GeneratedRandom(randVal);
    }
  }
  
  function chooseWinner() external onlyOwner {
    require(_contendersCount >= 2,"Not enough contenders registered");
    require(randValSet, "Random value not retrieved from oracle; call getRandomValue first.");
    uint winnerIndex = randVal % _contendersCount;
    _contendersCount = 0;
    payable(_contenders[winnerIndex]).transfer(address(this).balance - 1 ether);
    payable(_owner).transfer(1 ether);
  }
}