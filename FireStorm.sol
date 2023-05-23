//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

interface ERC20interface {
    function totalSupply() external  view returns (uint256);
    function balanceOf(address _owner) external  view returns (uint256 balance);
    function transfer(address _to, uint256 _value) external  returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external  returns (bool success);
    function approve(address _spender, uint256 _value) external  returns (bool success);
    function allowance(address _owner, address _spender) external  view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract FireStorm is ERC20interface{
    string public name="FireStorm";   
    string public symbol="FrStm" ;   
    uint public decimal= 0;
    uint public override totalSupply;
    address public founder;
    mapping (address=>uint) public balances;
    mapping (address=>mapping(address=>uint)) allowed;

    constructor(){
        totalSupply=1000;
        founder=msg.sender;
        balances[founder]= totalSupply;
    }

    function balanceOf(address tokenOwner) external  view override  returns (uint256 balance){
        return balances[tokenOwner];
    }

    function transfer(address to, uint256 tokens) external  override returns (bool success){
        require(balances[msg.sender]>=tokens,"You have not sufficient balance!!!");
        balances[to]+=tokens;
        balances[msg.sender]-=tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function allowance(address tokenOwner, address spender) external  view override returns (uint256 remaining){
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint256 tokens) external  override returns (bool success){
        require(balances[msg.sender]>=tokens, "You have not sufficient balance");
        require(tokens>0, "Zero no. of tokens can not be approved");
        allowed[msg.sender][spender]=tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    function transferFrom(address from, address to, uint256 tokens) external override  returns (bool success){
        require(allowed[from][to]>=tokens,"You are not approve for this much of tokens");
        require(balances[from]>=tokens,"You have not sufficient balance");
        balances[from]-=tokens;
        balances[to]+=tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    } 
}