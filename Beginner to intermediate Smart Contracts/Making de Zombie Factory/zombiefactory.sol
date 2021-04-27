pragma solidity ^0.8.4;

contract ZombieFactory {
    //Event: warn that a zombie was created
    event NewZombie(uint zombieId,string name,uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        // /$ CHANGE
        zombies.push(Zombie(_name, _dna)); //Add zombie in array
        uint id = zombies.length - 1;
        // $/ Change in a function "push" :ref(https://docs.soliditylang.org/en/develop/060-breaking-changes.html)
        
        emit NewZombie(id,_name,_dna);
    }
    //view: only can see the data but cannot edits
    //pure: You cannot access
    
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // /$ CHANGE
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // $/ Change using encondenPacked
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
//Keccak256 is the hash function, which is a version of SHA3.
//A hash function basically maps an input into a random 256-bit hexadecimal number.

//SPDX-License-Identifier: UNLICENSED