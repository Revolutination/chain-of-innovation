// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PBFTConsensus is Ownable {
    struct Proposal {
        bytes32 blockHash;
        address proposer;
        uint256 timestamp;
        uint256 votes;
        mapping(address => bool) hasVoted;
    }

    mapping(bytes32 => Proposal) public proposals;
    address[] public validators;
    uint256 public requiredVotes;

    event ProposalCreated(bytes32 indexed blockHash, address indexed proposer);
    event VoteCast(bytes32 indexed blockHash, address indexed validator);
    event ProposalValidated(bytes32 indexed blockHash);

    modifier onlyValidator() {
        require(isValidator(msg.sender), "Only validators can perform this action");
        _;
    }

    constructor(address[] memory _validators) {
        validators = _validators;
        requiredVotes = (_validators.length * 2) / 3 + 1; // 2/3 majority
    }

    function isValidator(address _validator) internal view returns (bool) {
        for (uint256 i = 0; i < validators.length; i++) {
            if (validators[i] == _validator) {
                return true;
            }
        }
        return false;
    }

    function proposeBlock(bytes32 _blockHash) public onlyValidator {
        require(proposals[_blockHash].timestamp == 0, "Proposal already exists");
        proposals[_blockHash] = Proposal(_blockHash, msg.sender, block.timestamp, 0);
        emit ProposalCreated(_blockHash, msg.sender);
    }

    function vote(bytes32 _blockHash) public onlyValidator {
        Proposal storage proposal = proposals[_blockHash];
        require(proposal.timestamp != 0, "Proposal does not exist");
        require(!proposal.hasVoted[msg.sender], "Validator has already voted");

        proposal.hasVoted[msg.sender] = true;
        proposal.votes++;

        emit VoteCast(_blockHash, msg.sender);

        if (proposal.votes >= requiredVotes) {
            emit ProposalValidated(_blockHash);
        }
    }

    function getProposalDetails(bytes32 _blockHash) public view returns (address proposer, uint256 votes) {
        Proposal storage proposal = proposals[_blockHash];
        return (proposal.proposer, proposal.votes);
    }
}
