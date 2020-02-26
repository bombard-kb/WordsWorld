pragma solidity ^0.5.0;

contract WordMetadata 
{
    using SafeMath for uint256;
    
    function tokenMetadata public view returns(string metadata)
    {
        string[] properties;
        string[] attributes;
        
        string metadata = '{';
        
        for (uint i = 0; i < properties.length; ++i)
            metadata += properties[i] + ',';
            
        metadata += '"attributes":['
        
        for (uint i = 0; i < attributes.length; ++i)
        {
            if (i > 0) metadata += ',';
            metadata += attributes[i];
        }
        
        metadata += ']}';
        
        return metadata; 
    }
}
