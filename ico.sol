pragma solidity ^0.4.11;

contract june_ico {

    uint public max_junecoins = 1000000;
    uint public usd_to_junecoins = 1000;
    uint public total_junecoins_bought = 0;c

    mapping(address => uint) equity_junecoins;
    mapping(address => uint) equity_usd;

    modifier can_buy_junecoins(uint usd_invested){
        require (usd_invested * usd_to_junecoins  + total_junecoins_bought <= max_junecoins);
        _;
    }

    function equity_in_junecoins(address investor) external constant returns (uint){
        return equity_junecoins[investor];
    }

    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }

    function buy_junecoins(address investor, uint usd_invested) external
    can_buy_junecoins(usd_invested) {
        uint junecoins_bought = usd_invested * usd_to_junecoins;
        equity_junecoins[investor] += junecoins_bought;
        equity_usd[investor] = equity_junecoins[investor] / 1000;
        total_junecoins_bought += junecoins_bought;
    }

    function sell_junecoins(address investor, uint junecoins_sold) external {
        equity_junecoins[investor] -= junecoins_sold;
        equity_usd[investor] = equity_junecoins[investor] / 1000;
        total_junecoins_bought -= junecoins_sold;
    }
}
