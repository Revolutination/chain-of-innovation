# Blockchain Design

The blockchain component of the Chain of Innovation utilizes a permissioned blockchain to ensure secure and efficient transactions. Key features include:

- **Smart Contracts**: Automate funding and verification processes.
- **Consensus Mechanism**: A hybrid approach combining Proof of Authority (PoA) and Practical Byzantine Fault Tolerance (PBFT) for transaction validation.
- **Data Storage**: Off-chain storage for large datasets, with hashes stored on-chain for integrity.

## Example Smart Contract (Solidity)

```solidity
1 // SPDX-License-Identifier: MIT
2 pragma solidity ^0.8.0;
3 
4 contract ResearchFunding {
5     struct Project {
6         address owner;
7         string title;
8         uint fundingGoal;
9         uint currentFunding;
10         bool isFunded;
11     }
12 
13     mapping(uint => Project) public projects;
14     uint public projectCount;
15 
16     function createProject(string memory _title, uint _fundingGoal) public {
17         projectCount++;
18         projects[projectCount] = Project(msg.sender, _title, _fundingGoal, 0, false);
19     }
20 
21     function fundProject(uint _projectId) public payable {
22         Project storage project = projects[_projectId];
23         require(msg.value > 0, "Funding must be greater than 0");
24         require(!project.isFunded, "Project already funded");
25 
26         project.currentFunding += msg.value;
27         if (project.currentFunding >= project.fundingGoal) {
28             project.isFunded = true;
29         }
30     }
31 }
```
