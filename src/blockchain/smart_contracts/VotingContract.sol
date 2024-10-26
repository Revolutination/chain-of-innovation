// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VotingContract is Ownable {
    struct Candidate {
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    uint public candidatesCount;
    uint public totalVotes;

    event CandidateAdded(uint indexed candidateId, string name);
    event Voted(uint indexed candidateId, address indexed voter);

    modifier hasNotVoted() {
        require(!voters[msg.sender], "You have already voted");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(_name, 0);
        emit CandidateAdded(candidatesCount, _name);
    }

    function vote(uint _candidateId) public hasNotVoted {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");

        voters[msg.sender] = true;
        candidates[_candidateId].voteCount++;
        totalVotes++;

        emit Voted(_candidateId, msg.sender);
    }

    function getResults() public view returns (string memory winnerName, uint winnerVoteCount) {
        uint winningVoteCount = 0;
        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winnerName = candidates[i].name;
            }
        }
        winnerVoteCount = winningVoteCount;
    }

    function resetVoting() public onlyOwner {
        for (uint i = 1; i <= candidatesCount; i++) {
            delete candidates[i];
        }
        delete voters;
        totalVotes = 0;
        candidatesCount = 0;
    }
}
