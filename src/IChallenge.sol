// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IChallenge {
    
    /// In the new world there's a curious thing,
    /// A tap that pours coins, like a magical spring
    /// A free-for-all place so vast,
    /// A resource that fills your wallet fast (cccccc)
    function solveChallenge1(string calldata riddleAnswer) external { }

    /// Onward we journey, through sun and rain
    /// A path we follow, with hope not in vain
    /// Guided by the Beacon Chain, with unwavering aim
    /// Our destination approaches, where two become the same (Ccc Ccccc)
    ///
    /// @dev These may be helpful: https://docs.ethers.org/v5/api/utils/hashing/ and
    /// https://docs.ethers.org/v5/api/signer/#Signer-signMessage
    function solveChallenge2(string calldata riddleAnswer, bytes calldata signature) external {}

    /// A proposal was formed, a new blob in the land,
    /// To help with the scale, and make things more grand
    /// A way to improve the network's high fees,
    /// And make transactions faster, with greater ease (CCC-NNNN)
    ///
    /// @dev These may be helpful: https://docs.ethers.org/v5/api/utils/hashing/ and
    /// https://docs.ethers.org/v5/api/signer/#Signer-signMessage
    function solveChallenge3(
        string calldata riddleAnswer,
        address signer,
        bytes calldata signature
    ) external { }

}