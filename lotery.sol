pragma solidity >=0.7.0 <0.9.0;

contract GuardaLoteria {
    uint256 numeroSorteado;
    address owner;
    uint256 prizeDrawCount = 0;
    bool richOwner = false;

    constructor(uint256 initialValue) {
        require(msg.sender.balance >= 99 ether);

        numeroSorteado = initialValue;
        owner = msg.sender;
        prizeDrawCount = 1;

        if (msg.sender.balance > 20) {
            richOwner = true;
        } else {
            richOwner = false;
        }
    }

    function set(uint256 enviado) public {
        prizeDrawCount++;
        numeroSorteado = enviado;
    }

    function get() public view returns (uint256) {
        return numeroSorteado;
    }

    function getCount() public view returns (uint256) {
        return prizeDrawCount;
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function fetOwnerRich() public view returns (bool) {
        return richOwner;
    }
}
