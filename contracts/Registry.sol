// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.13;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Create2.sol";

interface AuthToken{
    function safeMint(address to) external;
}

contract Registry is Ownable {
    using Address for address payable;
    
    uint private _authTokenCount;

    mapping(uint => address) TokenToContract;
    mapping(uint => uint) TokenToAmountLimit;
    mapping(uint => bytes32) TokenToAnswer;
    mapping(uint => address) TokenToRespondent;
    mapping(uint => uint) TokenToDeadline;
    mapping(uint => uint256) TokenToDeposit;
    mapping(address => mapping(uint => uint)) OwnerToBalance;


    function commit(uint token) public payable {
        require(TokenToDeadline[token] < block.number);
        require(msg.value == 0.01 ether);
        
        TokenToDeadline[token] = block.number + 1;
        TokenToRespondent[token] = msg.sender;
        TokenToDeposit[token] = TokenToDeposit[token] + (0.01 ether);
    }

    function answerAndMint(uint token, string memory answer) public {
        require(msg.sender == TokenToRespondent[token]);
        require(keccak256(abi.encodePacked(answer)) == TokenToAnswer[token]);
        require(OwnerToBalance[msg.sender][token] < TokenToAmountLimit[token]);

        AuthToken(TokenToContract[token]).safeMint(msg.sender);
        payable(msg.sender).sendValue(TokenToDeposit[token]);
        TokenToDeposit[token] = 0;
        OwnerToBalance[msg.sender][token]++;
    }

    function registerAuthToken(bytes memory code, bytes32 answerHash, uint amountLimit, string memory name, string memory symbol, bool isLocked) public onlyOwner {
        address addr;
        bytes memory bytecode;
        
        bytecode = abi.encodePacked(code, abi.encode(name, symbol, isLocked));
        addr = Create2.deploy(0, keccak256(abi.encodePacked(_authTokenCount)), bytecode);
        TokenToContract[_authTokenCount] = addr;
        TokenToAmountLimit[_authTokenCount] = amountLimit;
        TokenToAnswer[_authTokenCount] = answerHash;
        _authTokenCount++;
    }

}