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

    // _solveChallenge1();

    _solveChallenge2();
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

  function _signWithETHHash(uint256 privateKey, string memory message) public pure returns (bytes memory signature) {
    bytes32 messageHash = keccak256(abi.encodePacked(message));
    bytes32 hashWithETHHeader = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, hashWithETHHeader);        
    return abi.encodePacked(r, s, v);
  }
}

