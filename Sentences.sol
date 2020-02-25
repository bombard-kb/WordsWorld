// The code for ERC721 contract can be found via the link below: 
// https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721 

contract SENTENCE is ERC721Full {
    using SafeMath for uint256;

    struct Part 
    {
        address contract_address;
        uint id;
        bool capitalize;
        bool uppercase;
    }

    mapping(string  => uint256) value_to_id;
    mapping(uint256 => string) id_to_value;

    mapping(address => Part[]) drafts;

    constructor() ERC721Full("SENTENCE", "SENTENCE") public {
    }
    
    function _registerToken(string memory value) private {
        uint256 tokenId = totalSupply();
        
        id_to_value[tokenId] = value;
        value_to_id[value] = tokenId;
        
        _mint(msg.sender, tokenId);
    }
    
    function start() public 
    {
        memory Part[] draft;
        drafts[msg.sender] = draft;    
    }
    
    function add(address contract_address, uint id, bool capitalize, bool uppercase) public 
    {
        Part[] draft = drafts[msg.sender];
        
        draft.push(Part(contract_address, id, capitalize, uppercase));
        
        drafts[msg.sender] = draft;
    }
    
    function preview() public view 
    {
        string _preview = "";
        
        Part[] draft = drafts[msg.sender];
        
        for (uint i = 0; i < draft.length; ++i)
        {
            Part part = draft[i];
            _preview += ValueByIdWrapper(part.contract_address).value_by_id(part.id, 
                                                                            part.capitalize, 
                                                                            part.uppercase);
        }
        
        return _preview;
    }
    
    function commit(bool reset=true) public 
    {
        string new_sentence = preview();
        
        _registerToken(new_sentence);
        
        if (reset) start();
    }
}
