// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ResearchFunding is Ownable {
    using SafeMath for uint;

    struct Project {
        address payable owner;
        string title;
        uint fundingGoal;
        uint currentFunding;
        bool isFunded;
        mapping(address => uint) contributions;
    }

    mapping(uint => Project) public projects;
    uint public projectCount;

    event ProjectCreated(uint indexed projectId, string title, uint fundingGoal);
    event Funded(uint indexed projectId, address indexed contributor, uint amount);
    event ProjectFunded(uint indexed projectId);
    event FundsWithdrawn(uint indexed projectId, uint amount);

    modifier onlyProjectOwner(uint _projectId) {
        require(msg.sender == projects[_projectId].owner, "Only the project owner can perform this action");
        _;
    }

    function createProject(string memory _title, uint _fundingGoal) public {
        require(_fundingGoal > 0, "Funding goal must be greater than zero");
        projectCount++;
        projects[projectCount] = Project(payable(msg.sender), _title, _fundingGoal, 0, false);
        emit ProjectCreated(projectCount, _title, _fundingGoal);
    }

    function fundProject(uint _projectId) public payable {
        Project storage project = projects[_projectId];
        require(msg.value > 0, "Funding must be greater than 0");
        require(!project.isFunded, "Project already funded");

        project.currentFunding = project.currentFunding.add(msg.value);
        project.contributions[msg.sender] = project.contributions[msg.sender].add(msg.value);

        emit Funded(_projectId, msg.sender, msg.value);

        if (project.currentFunding >= project.fundingGoal) {
            project.isFunded = true;
            emit ProjectFunded(_projectId);
        }
    }

    function withdrawFunds(uint _projectId) public onlyProjectOwner(_projectId) {
        Project storage project = projects[_projectId];
        require(project.isFunded, "Project is not fully funded");

        uint amount = project.currentFunding;
        project.currentFunding = 0;
        project.owner.transfer(amount);

        emit FundsWithdrawn(_projectId, amount);
    }

    function getProjectDetails(uint _projectId) public view returns (string memory title, uint fundingGoal, uint currentFunding, bool isFunded) {
        Project storage project = projects[_projectId];
        return (project.title, project.fundingGoal, project.currentFunding, project.isFunded);
    }
}
