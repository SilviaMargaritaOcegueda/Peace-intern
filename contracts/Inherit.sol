// SPDX-License-Identifier: Unlicense
// pragma solidity ^0.8.0;

// @title addTestament function from the Heritage contract 

    // The Memory contract address
    address private memoryAddress;

    // Yet to be included on the Testator struct
    uint256 memoryId;

    //Call the mintMemory function from the Memory interface
    function createMemory(string memory _tokenURI) private returns (uint256 newItemId){
        IMemory(memoryAddress).mintMemory(_tokenURI);
    }

    function addTestament(
        address _inheritor,
        address _token,
        uint16 _maxDays,
        // URI of the memorial video or image
        string memory _tokenURI
    ) public greaterThan(_maxDays) uniqueTestator {
        require(
            inheritorToTestament[_inheritor] == address(0),
            "Inheritor already have a testament."
        );

        IERC20 token = IERC20(_token);

        uint256 _allowance = token.allowance(msg.sender, address(this));

        require(_allowance > 0, "Token allowance should be greater than 0.");

        // Mint and tranfer the memorial NFT to the testator address
        memoryId = createMemory(_tokenURI)

        Testator memory _testator = Testator(
            _inheritor,
            Status.ACTIVE,
            block.timestamp,
            _token,
            _maxDays
        );

        testaments[msg.sender] = _testator;

        inheritorToTestament[_inheritor] = msg.sender;

        emit NewTestament(
            msg.sender,
            _testator.inheritor,
            _testator.status,
            _testator.proofOfTimestamp,
            _testator.token,
            _testator.maxDays
        );
    }