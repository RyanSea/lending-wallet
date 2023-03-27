// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import { ERC721, ERC721TokenReceiver} from "solmate/tokens/ERC721.sol";

abstract contract LendingWalletBase is ERC721TokenReceiver {
    bytes4 public constant VALID = 0x1626ba7e;

    address internal owner; 

    constructor(address owner_) {
        owner = owner_;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "NOT_OWNER");
        _;
    }

    // review: just a placeholder for withdraws
    function call(address target, bytes calldata payload) external onlyOwner {
        (bool s, bytes memory r) = target.call(payload);

        require(s && r.length > 0 ? abi.decode(r, (bool)) : true, "CALL_FAILED");
    }

    function tranferOwnership(address owner_) external onlyOwner {
        owner = owner_;
    }

    function viewOwner() external view returns (address) {
        return owner;
    }

    function isValidSignature(bytes32 hash, bytes memory signature) external virtual view returns (bytes4);
    
    /// @notice transfers promissoryNote to owner
    /// review: should we be transfering the promissoryNote to the owner?
    /// review: probably doesn't need to be non-reentrant but let's talk about it
    function onERC721Received(
        address,
        address,
        uint256 id,
        bytes calldata
    ) external override returns (bytes4) {
        ERC721(msg.sender).safeTransferFrom(address(this), owner, id);

        return ERC721TokenReceiver.onERC721Received.selector;
    }
}
