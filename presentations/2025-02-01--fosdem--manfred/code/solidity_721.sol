// Solidity example for ERC721Receiver check
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}

// Solidity relies on checking bytes4 signature
require(
    contract.onERC721Received.selector == bytes4(keccak256("onERC721Received(address,address,uint256,bytes)")),
    "Invalid ERC721 receiver"
);
