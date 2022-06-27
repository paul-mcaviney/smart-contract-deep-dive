// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


/********************************************************/
/* For learning purposes ONLY. Do not use in production */
/********************************************************/


// Download into project folder with `npm install @openzeppelin/contracts`
import "@openzeppelin/contracts/access/Ownable.sol";

// Inherits the Ownable contract so we can use its functions and modifiers
contract HOABallot is Ownable {

    // Custom type to describe a Presidential Candidate and hold votes
    struct Candidate {
        string name;
        uint256 votes;
    }

    // Array of Presidential Candidates
    Candidate[] public candidates;
    

    // Add a President Candidate - onlyOwner
    function addCandidate(string memory _name) public onlyOwner {
        require(bytes(_name).length > 0, "addCandidate Error: Please enter a name");
        candidates.push(Candidate({name: _name, votes: 0}));
    }


    // Remove a Candidate - onlyOwner
    function removeCandidate(string memory _name) public onlyOwner {
        require(bytes(_name).length > 0, "removeCandidate Error: Please enter a name");
        bool foundCandidate = false;
        uint256 index;
        bytes32 nameEncoded = keccak256(abi.encodePacked(_name));

        // Set index number for specific candidate
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(abi.encodePacked(candidates[i].name)) == nameEncoded) {
                index = i;
                foundCandidate = true;
            }
        }

        // Make sure a candidate was found
        require(foundCandidate, "removeCandidate Error: Candidate not found");

        // shift candidate to be removed to the end of the array and the rest forward
        for (uint256 i = index; i < candidates.length - 1; i++) {
            candidates[i] = candidates[i + 1];
        }

        // remove last item from array
        candidates.pop();
    }


    // Reset the Candidate Vote Counts - onlyOwner
    function resetVoteCount() public onlyOwner {
        for (uint256 p = 0; p < candidates.length; p++) {
            candidates[p].votes = 0;
        }
    }


    // Add a vote to a candidate by name
    function addVoteByName(string memory _name) public {
        require(bytes(_name).length > 0, "addVoteByName Error: Please enter a name");
        // Encode name so only need to do once
        bytes32 nameEncoded = keccak256(abi.encodePacked(_name));

        for (uint256 i = 0; i < candidates.length; i++) {
            // solidity can't compare strings directly, need to compare hash
            if (keccak256(abi.encodePacked(candidates[i].name)) == nameEncoded) {
                candidates[i].votes += 1;
            }
        }
    }


    // Returns all the Presidential Candidates and their vote counts
    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }


    function getWinner() public view returns (Candidate memory winner) {
        uint256 winningVoteCount = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].votes > winningVoteCount) {
                winningVoteCount = candidates[i].votes;
                winner = candidates[i];
            }
        }

        return winner;
    }
    
}
