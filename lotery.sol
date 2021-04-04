pragma solidity >=0.7.0 <0.9.0;

contract GuardaLoteria {
    uint256 prizeDrawNumber;
    address owner;
    uint256 prizeDrawCount = 0;
    bool richOwner = false;

    constructor(uint256 initialValue) {
        require(msg.sender.balance >= 99 ether);

        prizeDrawNumber = initialValue;
        owner = msg.sender;
        prizeDrawCount = 1;

        if (msg.sender.balance > 20) {
            richOwner = true;
        } else {
            richOwner = false;
        }
    }

    /**
     *@dev set the prizeDrawNumber
     *@param sended new value of prizeDrawNumber
     */

    function setPrizeDrawNumber(uint256 sended) public {
        prizeDrawCount++;
        prizeDrawNumber = sended;
    }

    /**
     *@dev getPrizeDrawNumber return the current value of prizeDrawNumber
     */

    function getPrizeDrawNumber() public view returns (uint256) {
        return prizeDrawNumber;
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
