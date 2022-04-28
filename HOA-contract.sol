// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// need to install with `npm install @openzeppelin/contracts`
// More info here: https://docs.openzeppelin.com/contracts/4.x/api/access
 import "@openzeppelin/contracts/access/Ownable.sol";


contract HomeOwnersBallot is Ownable {

    address private owner;      // The address that initially deploys the contract becomes the owner

    // state variables for candidates
    
    
    constructor() {  // might not need this with the openzeppelin import
      owner = msg.sender;
    }

    function setCandidates() public onlyOwner {
        // takes in an object that is votable and sets the candidates, also setting votes to zero
    }

    function resetVotes() public onlyOwner {
        // takes in an object that contains the votes and sets it to zero
    }

    function addVote() public {
        // takes in a votable object and increases the vote count by 1
    }

    function getVotes() public {
        // returns the votes of a votable object
    }
    


}

// This is a smart contract for the Smart Contract Deep Dive article written by John Vester

// will need the following things:
//      1. Select the HOA President (single vote for multiple candidates)
//      2. Select the HOA Secretary (single vote for multiple candidates)
//      3. Select the HOA Treasurer (single vote for multiple candidates)
//      4. Select the HOA Improvement Board (three votes out of a list of multiple candidates)
//      5. Should we have a block party this year? (pick one of yes or no answers)
//      6. Should we have a neighborhood yard sale this year? (pick one of yes or no answers)
