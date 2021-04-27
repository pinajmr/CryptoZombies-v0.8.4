pragma solidity ^0.8.4;

contract ZombieFactory {

    event NewZombie(uint zombieId,string name,uint dna);
    
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    
    //Internal:internal is the same as private, except that it's also accessible to contracts that inherit from this contract
    //External:external is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract
    function _createZombie(string memory _name, uint _dna) internal {
        zombies.push(Zombie(_name, _dna)); 
        uint id = zombies.length - 1;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(id,_name,_dna);
    }

    //Storage: save permment (state variable)
    //memory: save temporal (internal function variable)
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

}
//Keccak256  is used for comparative of string
//For our contract to talk to another contract on the blockchain that we don't own, first we need to define an interface
//Solidity can return many values


//SPDX-License-Identifier: UNLICENSED