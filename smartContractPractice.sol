pragma solidity ^0.5.17;

contract SCPractice{
  struct Payment{
      uint amount;
      uint timestamps;
  }

  struct Balance{
      uint totalBalance;
      uint numPayments;
      mapping(uint => Payment) payments;
  }

  mapping(address => Balance) balanceReceived;

  function getBalance() public view returns(uint){
      return address(this).balance;
  }

  function sendMoney() public payable{
      balanceReceived[msg.sender].totalBalance += msg.value;
      Payment memory payment = Payment(msg.value, now);

      balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
      balanceReceived[msg.sender].numPayments++;
  }

  function partialWithdraw(address payable _to, uint amount) public{
      require(balanceReceived[msg.sender].totalBalance >= amount, "You don't have money" );
      balanceReceived[msg.sender].totalBalance -= amount;
      _to.transfer(amount);
  }

  function withdrawAllMoney(address payable _to) public {
      uint balanceToSend = balanceReceived[msg.sender].totalBalance;
      balanceReceived[msg.sender].totalBalance = 0;

      _to.transfer(balanceToSend);
  }
}
