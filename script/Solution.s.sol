// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import "forge-std/Script.sol";
import "../src/IChallenge.sol";
import "forge-std/console2.sol";

// run with:
// forge script script/Counter.s.sol:CounterScript --rpc-url $BASE_GOERLI_RPC_URL --broadcast --verify -vvvv
contract Solution is Script {
    function solveChallenge1() external {
        IChallenge challengeContract = IChallenge(0xc1e40f9FD2bc36150e2711e92138381982988791);
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        challengeContract.solveChallenge1("faucet", signer, signature);
        vm.stopBroadcast();
    }
}

