// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { LendingWalletBase } from "src/LendingWalletBase.sol";

import { IRegistry } from "src/interfaces/IRegistry.sol";

contract LendingWalletRegistry is LendingWalletBase {

    IRegistry internal registry;

    constructor(address owner_, address registry_) LendingWalletBase(owner_) {
        registry = IRegistry(registry_);
    }

    function changeRegistry(address registry_) external onlyOwner {
        registry = IRegistry(registry_);
    }

    function viewRegistry() external view returns (address) {
        return address(registry);
    }

    function isValidSignature(bytes32 hash, bytes memory) external override view returns (bytes4) {
        require(registry.validateOffer(hash), "INVALID_OFFER");

        return VALID;
    }
}