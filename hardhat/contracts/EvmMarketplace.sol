// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract EvmMarketplace {
    // Struct to represent a user
    struct User {
        address userAddress;
        string username;
    }

    // Struct to represent an asset
    struct Asset {
        string name;
        string description;
        uint256 price;
        address owner;
    }

    // Mapping of user addresses to User structs
    mapping(address => User) public users;

    // Array to store registered assets
    Asset[] public assets;

    // Event to log user registration
    event UserRegistered(address indexed userAddress, string username);

    // Event to log asset registration
    event AssetRegistered(string name, string description, uint256 price, address indexed owner);

    // Function to register a user
    function registerUser(string memory _username) public {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(users[msg.sender].userAddress == address(0), "User already registered");

        users[msg.sender] = User(msg.sender, _username);
        emit UserRegistered(msg.sender, _username);
    }

    // Function to register an asset
    function registerAsset(string memory _name, string memory _description, uint256 _price) public {
        require(bytes(_name).length > 0, "Asset name cannot be empty");
        require(_price > 0, "Price must be greater than 0");

        assets.push(Asset(_name, _description, _price, msg.sender));
        emit AssetRegistered(_name, _description, _price, msg.sender);
    }

      // Function to get all registered assets
    function getAllAssets() public view returns (Asset[] memory) {
        return assets;
    }

    // Function to get the total number of registered assets
    function getAssetCount() public view returns (uint256) {
        return assets.length;
    }

    // Function to get information about a specific asset by its index
    function getAssetByIndex(uint256 index) public view returns (string memory, string memory, uint256, address) {
        require(index < assets.length, "Invalid index");
        Asset storage asset = assets[index];
        return (asset.name, asset.description, asset.price, asset.owner);
    }
}
