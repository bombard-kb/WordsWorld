pragma solidity ^0.5.0;

contract WordMetadata 
{
    address owner;
    
    mapping(address => bool) managers;
 
    constructor() public {
        owner = msg.sender;
        managers[msg.sender] = true;
    }
    
    function _props(uint token) private view returns(string[] memory props)
    {
    }
    
    function _attrs(uint token) private view returns (string[] memory attrs)
    {
    }
    
    function tokenMetadata(uint token) public view returns(string memory metadata)
    {
        string[] memory properties = _props(token);
        string[] memory attributes = _attrs(token);
        
        metadata = '{';
        
        for (uint i = 0; i < properties.length; ++i)
            metadata = string(abi.encodePacked(metadata, properties[i], ','));
            
        metadata = string(abi.encodePacked(metadata, '"attributes":['));
        
        for (uint i = 0; i < attributes.length; ++i)
        {
            if (i > 0) metadata = string(abi.encodePacked(metadata, ','));
            metadata = string(abi.encodePacked(metadata, attributes[i]));
        }
        
        metadata = string(abi.encodePacked(metadata, ']}'));
        
        return metadata; 
    }
}
