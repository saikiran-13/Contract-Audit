// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Auction {
    uint256 startTime = block.timestamp + 1 days;
    uint256 EndTime = block.timestamp + 2 days;

    function startAuction() external view {
        require(block.timestamp >= startTime && block.timestamp < EndTime);
    }

    function EndAuction() external view {
        require(block.timestamp >= EndTime, "Cannot bid");
    }
}
