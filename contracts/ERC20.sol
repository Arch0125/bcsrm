// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ERC721.sol";

contract ERC20 is IERC20 {
    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;
    string public name = "Blockchain SRM";
    string public symbol = "BSM";
    uint8 public decimals = 18;
    string public nfturi = "";

    MyToken public NFTContract;

    constructor(address nftaddress, string memory _nfturi){
        NFTContract = MyToken(nftaddress);
        nfturi = _nfturi;
    }

    function approve(address spender, uint amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function burn(uint amount) internal {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function mint() external {
        balanceOf[msg.sender] += 1;
        totalSupply += 1;
        if(balanceOf[msg.sender]==9){
            burn(9);
            balanceOf[msg.sender]==0;
            NFTContract.safeMint(msg.sender, nfturi);
        }
        emit Transfer(address(0), msg.sender, 1);
    }

    
}
