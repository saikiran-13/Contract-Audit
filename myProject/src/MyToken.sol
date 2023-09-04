// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "forge-std/console.sol";

contract MyToken is ERC20 {
    address owner;

    constructor() ERC20("MyToken", "MTK") {
        owner = msg.sender;
        console.log("Owner of the contract", owner);
        console.log("Balance", address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function hello(uint256 y) public pure returns (string memory) {
        string memory x = "hello simform";
        return x;
    }

    function burn(uint256 _amount) external onlyOwner {
        _burn(msg.sender, _amount);
    }

    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }
}
