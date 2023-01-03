pragma solidity ^0.4.25;  // Declare Solidity Version

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);  
    // #  #  Event is used to tell that something has happened in you blockchain to your front end (web3.js)
    
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
    }
    // New data type Zombie is created which stores string and dna just like we do in c++
    

    Zombie[] public zombies;
    // Dynamic array of zombies is created which is public (in c -> int arr[10] in sol -> uint[10] arr) [10] = static array, [] = dynamic array 
    

    function _createZombie(string memory _name, uint _dna) private {
    // Private function is created so that it cannot be accessed by other contract (we use (_) for private declaration just for understanding)
    // _name is storing in memory
    
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // here id will be index of array from 1,2,3.. 
        
        emit NewZombie(id, _name, _dna);        
        // # # Combination of event and emit is used to notify the changes made in blockchain to web3.js
        
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
    // Data inside this function is just view not modifying
    // return type also needs to be declared with function
    
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // Typecasting of string into uint
        // keccak256 hash function of ethereum version of sha3
        
        return rand % dnaModulus;
        // As we need 16 bit hash value
        
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
