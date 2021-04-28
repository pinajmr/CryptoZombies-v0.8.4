pragma solidity ^0.8.4;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }
  // Function Modifiers: modifier onlyOwner (). Modifiers are like semi-functions that are used to modify other functions, usually to check some requirements before execution.
  // A function modifier is the same as a function, but uses the modifier keyword instead of function. But it cannot be called directly as a function - instead, we can add the modifier name to the end of the function definition to change the behavior of the function.
  // But it can be run on a sidechain with a different consensus algorithm.
  // But there is an exception to this: inside structs.
  function changeName(uint _zombieId, string memory _newName) external aboveLevel(2, _zombieId) {// $Change use memory
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) { // $Change use memory
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}


//SPDX-License-Identifier: UNLICENSED