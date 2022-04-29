// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/********************************************************/
/* For learning purposes ONLY. Do not use in production */
/********************************************************/

// Download into project folder with `npm install @openzeppelin/contracts`
import "@openzeppelin/contracts/access/Ownable.sol";

// Inherits the Ownable contract so we can use its functions and modifiers
contract HomeOwnersBallot is Ownable {

    // Custom type to describe a Presidential Candidate and hold votes
    struct Candidate {
        string name;
        uint256 votes;
    }

    // Array of Presidential Candidates
    Candidate[] public presidents;

    // Initialize the contract with a few candidates
    constructor() {
        presidents.push(Candidate({name: "Bob", votes: 0}));
        presidents.push(Candidate({name: "Alice", votes: 0}));
        presidents.push(Candidate({name: "Billy", votes: 0}));
        presidents.push(Candidate({name: "Gertrude", votes: 0}));
    }

    // Add a Presidential Candidate - onlyOwner
    function addCandidate(string memory _name) public onlyOwner {
        presidents.push(Candidate({name: _name, votes: 0}));
    }

    // Remove a Candidate - onlyOwner
    function removeCandidate(string memory _name) public onlyOwner {
        uint256 _index;
        bytes32 nameEncoded = keccak256(abi.encodePacked(_name));

        // Set index number for specific candidate
        for (uint256 i = 0; i < presidents.length; i++) {
            if (keccak256(abi.encodePacked(presidents[i].name)) == nameEncoded) {
                _index = i;
            }
        }

        // shift candidate to be remove to the end of the array and the rest forward
        for (uint256 i = _index; i < presidents.length - 1; i++) {
            presidents[i] = presidents[i + 1];
        }

        // remove last item from array
        presidents.pop();
    }

    // Reset the President Vote Counts - onlyOwner
    function resetVoteCount() public onlyOwner {
        for (uint256 p = 0; p < presidents.length; p++) {
            presidents[p].votes = 0;
        }
    }

    // Add a vote to a candidate by name
    function addVoteByName(string memory _name) public {
        // Encode name so only need to do once
        bytes32 nameEncoded = keccak256(abi.encodePacked(_name));

        for (uint256 i = 0; i < presidents.length; i++) {
            // solidity can't compare strings directly, need to compare hash
            if (keccak256(abi.encodePacked(presidents[i].name)) == nameEncoded) {
                presidents[i].votes += 1;
            }
        }
    }

    // Returns all the Presidential Candidates and their vote counts
    function getPresidents() public view returns (Candidate[] memory) {
        return presidents;
    }

    // Decide the winner based on vote count
    function getWinner() public view returns (Candidate memory winner) {
        uint256 winningVoteCount = 0;

        for (uint256 i = 0; i < presidents.length; i++) {
            if (presidents[i].votes > winningVoteCount) {
                winningVoteCount = presidents[i].votes;
                winner = presidents[i];
            }
        }

        return winner;
    }
}
