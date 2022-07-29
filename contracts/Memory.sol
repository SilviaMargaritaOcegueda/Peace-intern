//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

string constant _name = "Memory";
string constant _symbol = "MEMT";

contract Memory is ERC721 {

    uint256 public tokenCounter;
    
    constructor () public ERC721 (_name, _symbol){
        tokenCounter = 0;
    }
    
    function mintMemory(string memory _tokenURI) internal returns (uint256) {
        uint256 newItemId = tokenCounter;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, _tokenURI);
        tokenCounter = tokenCounter++;
        return newItemId;
    }
}