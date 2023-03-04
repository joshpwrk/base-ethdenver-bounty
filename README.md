### Solution to Base ETHDenver Bounty Challenge ###

I spent a Saturday afternoon competing in Base's 2023 bounty. Figured I clean up the solution and post publicly for anyone who's curious how it was solved.

TLDR: Signatures can be 64bits or 65bits long. If you have a quirky implementation of `ECDSA.sol` (like Base did on purpose) you can end up with two different signatures that result in the same signer. 

Challenge description: https://www.coinbase.com/bounty/ethdenver23

## Solution Overview

Challenges 1 & 2 were quite straight-forward and do not need any explanation apart from the actual code in `Solution.s.sol`. 

The third challenge, however, was a tough nut to crack. Here's the logical steps that led me to finding the solution:
1) Realize that the only way to pass is to submit two different signatures that result in the same signer
2) Actual ECDSA collisions are not practical - we'd have bigger issues if they were
3) Considered maybe `abi.encodePacked` created some weird inconsistencies, but L136 specifically checked post packed results so that wasn't it
4) Finally I figured I'd take a look at how the `ecrecover` was done
5) I figured if there are any weird tricks, they will show in the diff between OpenZepellin's [ECDSA.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/ECDSA.sol) contract.
6) Noticed that Base challenge added another branch where signature can either be 64 or 65 bytes long. 
7) From here on it was pretty quick to realize that packing `v` into `s` would result in a different signature

## Installation and Build

```shell
git submodule update --init --recursive
forge build
```

## Running on-chain

Create a local `.env` file with the below vars:
```shell
PRIVATE_KEY=
PUBLIC_ADDRESS=
BASE_GOERLI_RPC_URL='https://goerli.base.org'
```

Then run the Solution.s.sol script to complete all three challenges in one go:
```shell
source .env
forge script script/Solution.s.sol:Solution --rpc-url $BASE_GOERLI_RPC_URL --broadcast --verify -vvvv
```