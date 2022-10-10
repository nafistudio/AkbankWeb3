// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract NftCon is ERC721, Ownable {
    uint256 public mintPrice = 0.05 ether;
    uint256 public totalProduct;
    uint256 public maxProduct;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721('Simple Mint', 'SIMPLEMINT') {
        maxProduct = 2;
    }

    function toggleIsMintEnabled() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxProduct(uint256 maxProduct_) external onlyOwner{
        maxProduct = maxProduct_;
    }

    function mint() external payable {
        require(isMintEnabled, 'minting not enabled');
        require(mintedWallets[msg.sender] < 1, 'exceeds max per wallet');
        require(msg.value == mintPrice, 'wrong value');
        require(maxProduct > totalProduct, 'sold out');

        mintedWallets[msg.sender]++;
        totalProduct++;
        uint256 tokenId = totalProduct;
        _safeMint(msg.sender, tokenId);

    }
}