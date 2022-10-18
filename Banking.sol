pragma solidity >=0.7.0 <0.9.0;
//SPDX-License-Identifier: UNLICENSED
contract Bank{
    mapping(address => uint) public balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    function deposit() public payable{
        balances[msg.sender] += msg.value; 
    }
    
    function withdraw(uint _amount) public{
        require(balances[msg.sender]>= _amount, "Not enough ether");
        (bool sent,) = msg.sender.call{value: _amount}("Sent");
        require(sent, "failed to send ETH");
    }
    
     function transfer(address receiver, uint256 eth) public returns (bool) {
        require(eth <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender]-eth;
        balances[receiver] = balances[receiver]+eth;
        emit Transfer(msg.sender, receiver, eth);
        return true;
    }
    function getBal() public view returns(uint){
        return address(this).balance;
    }
}