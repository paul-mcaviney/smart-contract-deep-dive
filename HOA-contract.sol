// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HomeOwnersBallot {

struct President {
    string name;
    uint votes;
}

// An array to hold the president candidates
President[] public presidents; 

constructor() {
    presidents.push(President({name: "Bob", votes: 0}));
    presidents.push(President({name: "Alice", votes: 0}));
    presidents.push(President({name: "Billy", votes: 0}));
    presidents.push(President({name: "Gertrude", votes: 0}));
}

// Add a President Candidate - onlyOwner
function addCandidate(string memory _name) public {
    presidents.push(President({name: _name, votes: 0}));
}

// Remove a Candidate - onlyOwner
function removeCandidate(uint _index) public {
    for (uint i = _index; i < presidents.length-1; i++){
      presidents[i] = presidents[i+1];      
    }
    presidents.pop();
}

// Reset the President Vote Counts - onlyOwner
function resetVoteCount() public {
    for (uint p = 0; p < presidents.length; p++) {
        presidents[p].votes = 0;
    }
}

// Add a vote to a candidate by name
// function addVote(string memory _name) public {
//     for (uint i = 0; i < presidents.length-1; i++) {
//         // solidity can't compare strings directly
//         if (keccak256(abi.encodePacked(presidents[i].name)) == keccak256(abi.encodePacked(_name))) {
//             presidents[i].votes += 1;
//         }
//     } 
// }

// Add a vote to candidate by their index number
function addVote(uint _index) public {
    presidents[_index].votes++;
}

function getWinner() public view returns (string memory winner) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < presidents.length; i++) {
            if (presidents[i].votes > winningVoteCount) {
                winningVoteCount = presidents[i].votes;
                winner = presidents[i].name;
            }
        }

        return winner;
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
