// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol

interface ERC20Interface {
   
    //Returns total token supply
    function totalSupply() external view returns (uint);
    
    //Returns the account balance using token owner address
    function balanceOf(address tokenOwner) external view returns (uint balance);
    
    function transfer(address recipient, uint amount) external returns (bool success);
   
    //Returns the amount which spender is still allowed to withdraw from tokenOwner
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    
    //Allows spender to withdraw from your account multiple times, up to the tokens amount.
    function approve(address spender, uint tokens) external returns (bool success);

    //Transfers tokens amount of tokens from address from to address to, and MUST fire the Transfer event
    function transferFrom(
        address from,
        address to,
        uint tokens
    ) external returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
