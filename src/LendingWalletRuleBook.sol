// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { LendingWalletBase } from "src/LendingWalletBase.sol";

import { IRuleBook } from "src/interfaces/IRuleBook.sol";

contract LendingWalletRuleBook is LendingWalletBase {

    IRuleBook internal rulebook;

    constructor(address owner_, address rulebook_) LendingWalletBase(owner_) {
        rulebook = IRuleBook(rulebook_);
    }

    function changeRulebook(address rulebook_) external onlyOwner {
        rulebook = IRuleBook(rulebook_);
    }

    function viewRulebook() external view returns (address) {
        return address(rulebook);
    }

    function isValidSignature(bytes32 hash, bytes memory) external override view returns (bytes4) {
        require(rulebook.validateOffer(hash, msg.sender), "INVALID_OFFER");

        return VALID;
    }
}