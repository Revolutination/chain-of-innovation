// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PoAConsensus is Ownable {
    struct Validator {
        address validatorAddress;
        bool isActive;
    }

    mapping(address => Validator) public validators;
    address[] public validatorList;

    event ValidatorAdded(address indexed validator);
    event ValidatorRemoved(address indexed validator);
    event BlockProposed(bytes32 indexed blockHash, address indexed proposer);
    event BlockValidated(bytes32 indexed blockHash, address indexed validator);

    modifier onlyValidator() {
        require(validators[msg.sender].isActive, "Only active validators can perform this action");
        _;
    }

    function addValidator(address _validator) public onlyOwner {
        require(!validators[_validator].isActive, "Validator already exists");
        validators[_validator] = Validator(_validator, true);
        validatorList.push(_validator);
        emit ValidatorAdded(_validator);
    }

    function removeValidator(address _validator) public onlyOwner {
        require(validators[_validator].isActive, "Validator does not exist");
        validators[_validator].isActive = false;
        emit ValidatorRemoved(_validator);
    }

    function proposeBlock(bytes32 _blockHash) public onlyValidator {
        emit BlockProposed(_blockHash, msg.sender);
    }

    function validateBlock(bytes32 _blockHash) public onlyValidator {
        emit BlockValidated(_blockHash, msg.sender);
    }

    function getValidators() public view returns (address[] memory) {
        return validatorList;
    }
}
