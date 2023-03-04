// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "../src/IChallenge.sol";
import "forge-std/console2.sol";

// run with:
// forge script script/Solution.s.sol:Solution --rpc-url $BASE_GOERLI_RPC_URL --broadcast --verify -vvvv
contract Solution is Script {
  uint256 competitorPK;
  address competitorPB; 
  IChallenge challengeContract;

  function run() external {
    challengeContract = IChallenge(0xc1e40f9FD2bc36150e2711e92138381982988791);
    competitorPK = vm.envUint("PRIVATE_KEY");
    competitorPB = vm.envAddress("PUBLIC_ADDRESS");

    _solveChallenge1();

    _solveChallenge2();

    _solveChallenge3();

  }

  function _solveChallenge1() internal {
    vm.startBroadcast(competitorPK);
    challengeContract.solveChallenge1("faucet");
    vm.stopBroadcast();
  }

  function _solveChallenge2() internal {
    vm.startBroadcast(competitorPK);
    bytes memory signature = _signWithETHHash(competitorPK, "The Merge");
    challengeContract.solveChallenge2("The Merge", signature);
    vm.stopBroadcast();
  }

  function _solveChallenge3() internal {
    vm.startBroadcast(competitorPK);
    bytes memory sig65Byte = _signWithETHHash(competitorPK, "EIP-4844");
    challengeContract.solveChallenge3("EIP-4844", competitorPB, sig65Byte);

    bytes memory sig64Byte = _signWith64Bytes(competitorPK, "EIP-4844");
    challengeContract.solveChallenge3("EIP-4844", competitorPB, sig64Byte);
    vm.stopBroadcast();
  }


  /////////////
  // Helpers //
  /////////////

  function _signWithETHHash(uint256 privateKey, string memory message) public pure returns (bytes memory signature) {
    (uint8 v, bytes32 r, bytes32 s) = _signWithVRS(privateKey, message);        
    return abi.encodePacked(r, s, v);
  }

  function _signWith64Bytes(uint256 privateKey, string memory message) public returns (bytes memory) {
    (uint8 v, bytes32 r, bytes32 s) = _signWithVRS(privateKey, message);        

    // limit length of signature to 64 bits
    bytes memory signature = new bytes(64);

    // set the highest-order byte to 0 as this will be read as "v"
    // effectively makes s -> vs
    s &= bytes32(0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);

    // store r and vs into 64 byte array
    assembly {
        mstore(add(signature, 0x20), r)
        mstore(add(signature, 0x40), s)
    }

    return signature;
  }

  function _signWithVRS(uint256 privateKey, string memory message) public pure returns (uint8 v, bytes32 r, bytes32 s) {
    bytes32 messageHash = keccak256(abi.encodePacked(message));
    bytes32 hashWithETHHeader = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    (v, r, s) = vm.sign(privateKey, hashWithETHHeader);     
  }
}

