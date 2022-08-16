// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol

import "./erc20Interface.sol";
contract ERC20Token is ERC20Interface {
    //Max tokens constant
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;

    //list of token allowed to transfer to one address to list of address
    mapping (address => mapping (address => uint256)) public allowed;
    
    uint public totSupply;                // Total number of tokens            
    string public name;                   // Descriptive name (i.e. For SupplyChainApp Token)
    uint8 public decimals;                // How many decimals to use when displaying amounts
    string public symbol;                 // Short identifier for token (i.e. FDT)
    
    // Create the new token and assign initial values, including initial amount
    constructor(
    uint256 _initialAmount,
    string memory _tokenName,
    uint8 _decimalUnits,
    string memory _tokenSymbol
    ) public {
    balances[msg.sender] = _initialAmount;         // The creator owns all initial tokens
    totSupply = _initialAmount;                    // Update total token supply
    name = _tokenName;                             // Store the token name (used for display only)
    decimals = _decimalUnits;                      // Store the number of decimals (used for display only)
    symbol = _tokenSymbol;                         // Store the token symbol (used for display only)
    }

    // Transfer tokens from msg.sender to a specified address
    function transfer(address _to, uint256 _value) public returns (bool success) {
    require(balances[msg.sender] >= _value,"Insufficient funds for transfer source.");
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    //Just notify sender and receiver that transaction is done
    emit Transfer(msg.sender, _to, _value); 
    return true;
    }

    

    // Transfer tokens from one specified address to another specified address
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    uint256 allow = allowed[_from][msg.sender];
    require(balances[_from] >= _value && allow >= _value,"Insufficient allowed funds for transfer source.");
    balances[_to] += _value;
    balances[_from] -= _value;
    if (allow < MAX_UINT256) {
    allowed[_from][msg.sender] -= _value;
    }
    emit Transfer(_from, _to, _value); 
    return true;
    }

    // Return the current balance (in tokens) of a specified address
    function balanceOf(address _owner) public view returns (uint256 balance) {
    return balances[_owner];
    }

    // Returns the amount which _spender is still allowed to withdraw from _owner.
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
    return allowed[_owner][_spender];
    }
    
    //Allows _spender to withdraw from your account multiple times, up to the _value amount.
    function approve(address _spender, uint256 _value) public returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value); //solhint‐disable‐line indent, no‐unused‐vars
    return true;
    }

    
    
    // Return the total number of tokens in circulation
    function totalSupply() public view returns (uint256 totSupp) {
    return totSupply;
    }
}