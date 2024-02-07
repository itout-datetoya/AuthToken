// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.13;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import { ERC5192 } from "./ERC5192/ERC5192.sol";

contract AuthToken is ERC5192, Ownable {
    uint private tokenId;

    constructor(string memory _name, string memory _symbol, bool _isLocked)
    ERC5192(_name, _symbol, _isLocked){}

    function safeMint(address to) public onlyOwner {
        _safeMint(to, tokenId);
        tokenId++;
    }

}