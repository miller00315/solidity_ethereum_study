// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Lotery {
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

    event SendedAmount(address payAddress, uint256 amount);

    /**
     *@dev set the prizeDrawNumber
     *@param sended new value of prizeDrawNumber
     */
    function set(uint256 sended) public payable withMinValue(1000) {
        prizeDrawCount++;
        prizeDrawNumber = sended;

        if (msg.value > 1000) {
            uint256 amount = msg.value - 1000;

            // Set a payable addres to send a value
            payable(address(uint160(msg.sender))).transfer(amount);

            emit SendedAmount(msg.sender, amount);
        }
    }

    /**
     *@dev withMinValue check if is sended the min value of ether
     * @param minValue minimun value of ether
     **/
    modifier withMinValue(uint256 minValue) {
        require(msg.value >= minValue, "Not enough ether was sent");
        _;
    }

    /**
     *@dev getPrizeDrawNumber return the current value of prizeDrawNumber
     */
    function getPrizeDrawNumber() public view returns (uint256) {
        return prizeDrawNumber;
    }

    /**
     *@dev getCount return the count of preize draw
     */
    function getCount() public view returns (uint256) {
        return prizeDrawCount;
    }

    /**
     *@dev getOwner return the address of the owner
     */
    function getOwner() public view returns (address) {
        return owner;
    }

    /**
     *@dev fetOwnerRich return the value of richOwner (true or false)
     */
    function fetOwnerRich() public view returns (bool) {
        return richOwner;
    }
}
