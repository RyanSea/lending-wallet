// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IRuleBook {
    /// checks rule book against msg.sender (user) and lending platform (so we know how to decode the hash), and hash
    function validateOffer(bytes32 hash, address platform) external view returns (bool);
}