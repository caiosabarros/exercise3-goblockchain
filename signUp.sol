//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <=0.9.0;

//signUp to give your data and to check if you are the richest that have signedUp
//by donating some ETH


contract signUp {

    address owner;
    address public richest;
    uint256 public balance_of_richest;
    uint256 private contract_balance;

    constructor(){
        owner = msg.sender;
        richest = msg.sender;
        balance_of_richest = address(msg.sender).balance;
    }

    //map cpf with struct
    struct SignUp {
        uint256 age;
        string first_name;
        uint256 phone;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    mapping (uint256 => SignUp) public id;

    function signingUp(uint256 _cpf, uint256 _age, string memory _first_name, uint256 _phone ) public payable { 
        //Donation required to use contracts function
        require(msg.value > 100000000000, "Send ETH!");

        //Collect Data
        SignUp storage person = id[_cpf];
        person.age = _age;
        person.first_name = _first_name;
        person.phone = _phone;
        
        //Check to see if person is the richest to interact with contract
        uint256 value = address(msg.sender).balance;
        if(value > balance_of_richest){
          //if the person is the richest, let everyone know
            richest = msg.sender;
            balance_of_richest = address(msg.sender).balance;
        }
        contract_balance = address(this).balance;
    }

    //only owner can get access to how much has been donated to contract
    function balanceOfRichest() public onlyOwner view returns (uint256) {
        return contract_balance;
    }

//Some notes for draft:

//the richest! Deposit some ETH to the contract for contribution and then
//I will save the person's balance. If its more than the last richest, update.
//If not, say: you're not the richest! Do not show how much the richest has!
//Only owner can access the balance of the richest.
// emit an event in Js for person to fill out his name if he's the richest!
//Or emit an event for person to type in their name if theycall the function to singup for richest

}