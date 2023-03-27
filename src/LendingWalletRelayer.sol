// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { LendingWalletBase } from "src/LendingWalletBase.sol";

import { ECDSA } from "openzeppelin/utils/cryptography/ECDSA.sol";

/// @notice implementation of lending wallet that verifies sig by relayer address 
contract LendingWalletRelayer is LendingWalletBase {
    using ECDSA for bytes32;

    mapping(address relayer => bool isValid) internal relayers;

    constructor(address owner_, address gsax) LendingWalletBase(owner_) {
        relayers[gsax] = true;
    }

    function setRelayer(address relayer, bool isValid) external onlyOwner {
        relayers[relayer] = isValid;
    }

    function checkRelayer(address relayer) external view returns (bool) {
        return relayers[relayer];
    }

    function isValidSignature(bytes32 hash, bytes memory signature) external override view returns (bytes4) {
        require(relayers[hash.recover(signature)], "INVALID_RELAYER");

        return VALID;
    }
}

