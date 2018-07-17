pragma solidity ^0.4.0;

contract MyContract {
    uint256 private  value;
    
    function GetValue() payable public returns(uint256)
    {
        return value;
    }
    
    function SetValue(uint256 t_value) public 
    {
        value = t_value;
    }
   
}