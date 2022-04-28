// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HomeOwnersBallot {

struct President {
    string name;
    uint votes;
}

President[] public presidents;

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
function addVote(string memory _name) public {
    for (uint i = 0; i < presidents.length-1; i++){
        // solidity can't compare strings directly
        if (keccak256(abi.encodePacked(presidents[i].name)) == keccak256(abi.encodePacked(_name))) {
            presidents[i].votes++;
        }
    } 
}


}