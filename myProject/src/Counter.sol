// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/console.sol";

contract Counter {
    uint256 public number;
    address public owner;

    event incrementDone(uint256 _number);
    event decrementDone(uint256 _number);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the Owner");
        _;
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        number = newNumber;
    }

    function increment() public {
        number++;
        emit incrementDone(number);
    }

    function decrement() public {
        number--;
        emit decrementDone(number);
    }

    function setOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    function hello(string memory y) public view returns (string memory) {
        require(msg.sender != address(0));
        string memory z = "hello";
        return z;
    }
    //if u remove the comments and run the command below and u will find 1 collision as hello fn is present in both contracts
    //forge selectors collision ./src/Counter.sol:Counter ./src/Erc20.sol:MyToken
}
