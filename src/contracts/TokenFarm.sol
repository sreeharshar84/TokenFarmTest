pragma solidity ^0.5.0;

//import "./DaiToken.sol";
//import "./DappToken.sol";

interface DaiToken {
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);
}


contract TokenFarm {
    string public name = "Dapp Token Farm";
    //DappToken public dappToken;
    DaiToken public daiToken;
    address owner;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    /*
       Kovan DAI: 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa
    */
    constructor() public {
        //dappToken = _dappToken;
        daiToken = DaiToken(0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa);
        owner = msg.sender;
    }

    function stakeTokens(uint _amount) public {

        // amount should be > 0
        require(_amount > 0, "amount should be > 0");

        // transfer Dai to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);
        
        // update staking balance
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        // Add user to stakers only if they haven't already been added
        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;   
    }

    // Unstaking Tokens (Withdraw)
    function unstakeTokens() public {
        uint balance = stakingBalance[msg.sender];

        // balance should be > 0
        require (balance > 0, "staking balance cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);

        // reset staking balance to 0
        stakingBalance[msg.sender] = 0;

        // update staking status
        isStaking[msg.sender] = false;
    }
}