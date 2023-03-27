// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

interface IRegistry {
    /// checks rule book against msg.sender (user) and hash
    function validateOffer(bytes32 hash) external view returns (bool);
}