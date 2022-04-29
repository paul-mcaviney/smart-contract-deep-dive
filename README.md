# Home Owners Association Presidential Election Smart Contract

This is a smart contract accompanying the Smart Contract Deep Dive technical article <link> written by [John Vester](https://johnjvester.gitlab.io/dZoneStatistics/WebContent/#/stats?id=1224939). 

---
>**Note**: This smart contract is for learning purposes only and not to be used in production!

---

This smart contract is intended to decide who the winner of the presidential election is for the Home Owners Association. It has functions for adding new candidates, removing candidates, resetting the vote count, adding votes, and deciding the winner.

It also inherits from OpenZeppelin's Ownable contract to enable access controls for certain functions. A regular user should not be able to add or remove candidates, or reset the votes.
