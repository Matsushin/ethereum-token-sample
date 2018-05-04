pragma solidity ^0.4.23;
import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract AppToken is StandardToken {
  string public name;
  string public symbol;
  uint8 public decimals = 4;

  function AppToken(string _name, string _symbol, uint _totalSupply) public {
    totalSupply_ = _totalSupply;
    balances[msg.sender] = _totalSupply;
    name = _name;
    symbol = _symbol;
  }
}
