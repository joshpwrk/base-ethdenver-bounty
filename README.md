### Solution to Base ETHDenver Bounty Challenge ###

I spent a Saturday afternoon competing in Base's 2023 bounty. Figured I clean up the solution and post publicly for anyone who's curious how it was solved.

Challenge description: https://www.coinbase.com/bounty/ethdenver23

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