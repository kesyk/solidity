pragma solidity ^0.4.10;

contract ContentManagementSystem {
    struct Article {
        string title;
        string content;
        address author;
        uint creationDateTime;
        uint lastUpdateDateTime;
    }
    
    mapping (address => mapping(uint => Article)) private _articles;

    mapping (address => bool) private _admins;

    constructor ()  public {
        _admins[0xc1912fEE45d61C87Cc5EA59DaE31190FFFFf232d] = true;
        _admins[0xCf5609B003B2776699eEA1233F7C82D5695cC9AA] = true;
    }

    function createArticle( address userAddress,uint articleId, string title,string content ) public
    {
        _articles[userAddress][articleId] = Article(title,content,userAddress,now,0);
    }
    
    function editArticle( address userAddress,uint articeId,string title,string content ) isAdminOrAuthor(userAddress,articeId) public
    {
        _articles[userAddress][articeId].title = title;
        _articles[userAddress][articeId].content = content;
        _articles[userAddress][articeId].lastUpdateDateTime = now;
    }
        
    function getArticle( address userAddress, uint articeId ) view public returns (string,string)
    {
        return (_articles[userAddress][articeId].title,_articles[userAddress][articeId].content);
    }
    
    function deleteArticle( address userAddress, uint articeId ) isAdminOrAuthor(userAddress,articeId) public
    {
        delete _articles[userAddress][articeId];
    }

    modifier isAdminOrAuthor (address userAddress, uint articeId) {
         _;
        require( _admins[userAddress]  || _articles[userAddress][articeId].author==userAddress);
    }
}