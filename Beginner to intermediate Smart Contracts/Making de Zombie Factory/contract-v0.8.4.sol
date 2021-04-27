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

    function _createZombie(string memory _name, uint _dna) private {
        // /$ CHANGE
        zombies.push(Zombie(_name, _dna)); 
        uint id = zombies.length-1;
        // $/ Change in a function "push" :ref(https://docs.soliditylang.org/en/develop/060-breaking-changes.html)
        
        emit NewZombie(id,_name,_dna);
    }

    
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

//SPDX-License-Identifier: UNLICENSED