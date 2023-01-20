// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract LMS {
    struct S1 {
        uint256 id;
        string name;
        string owner;
    }
    address public owner;
    constructor() 
    {
        owner = msg.sender;
    }
    S1[] books;
    mapping(address =>mapping(uint=>S1)) private addr;
    uint count=0;
    
    address[]  private own_addr;
    mapping(address=>uint) private noOfBooks;
    S1 book1;

    function addBook(  uint256 _id, string memory _name,  string memory _owner ) public {
         require(msg.sender == owner);
        books.push(S1(_id, _name, _owner));
         book1 = S1(_id, _name, _owner);
         count=_id;
        addr[owner][count] = book1;
        noOfBooks[owner]++;
        
    }
    function transfer(address bookTransfer, uint _id) public {
        require(msg.sender == owner);
        addr[bookTransfer][_id]=addr[owner][_id];
        delete addr[owner][_id];
        noOfBooks[msg.sender]--;
        noOfBooks[bookTransfer]++;

    }
    
      function getBooks(uint idd) public view returns (uint256, string memory, string memory )
    {
        
        return (

             addr[msg.sender][idd].id,
            addr[msg.sender][idd].name,
            
           
            addr[msg.sender][idd].owner
        );
    }
    function totalBooks() public view returns(uint256){
       return noOfBooks[msg.sender];
    }
     function returnBook( uint _id) public {
       require(msg.sender != owner); 
        addr[owner][_id]=addr[msg.sender][_id];
        delete addr[msg.sender][_id];
        noOfBooks[owner]++;
        noOfBooks[msg.sender]--;

    }
    
}
