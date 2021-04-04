// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

struct OwnerStruct {
    address ownerAddress;
    string ownerName;
    bool richOwner;
}

contract Lotery {
    uint256 private prizeDrawNumber;
    OwnerStruct private owner;
    uint16 private prizeDrawCount = 0;

    uint16[] private numbersDrawn;

    constructor(uint256 initialValue) {
        require(msg.sender.balance >= 99 ether);

        owner = OwnerStruct(msg.sender, "", msg.sender.balance > 20);

        prizeDrawNumber = initialValue;
        prizeDrawCount = 1;
    }

    event SendedAmount(address payAddress, uint256 amount);

    /**
     *@dev set the prizeDrawNumber
     *@param sended new value of prizeDrawNumber
     */
    function set(uint16 sended) public payable withMinValue(1000) {
        require(
            msg.sender == owner.ownerAddress,
            "Only the contract's owner can set the value"
        );

        prizeDrawNumber = sended;

        numbersDrawn.push(sended);

        if (msg.value > 1000) {
            uint256 amount = msg.value - 1000;

            // Set a payable addres to send a value
            payable(address(uint160(msg.sender))).transfer(amount);

            emit SendedAmount(msg.sender, amount);
        }

        prizeDrawCount++;
    }

    /**
     *@dev setUserName set the owner's name
     *@param name the owner's name that will be set
     */
    function setUserName(string memory name) public {
        require(owner.ownerAddress != address(0), "Owner is not set");

        owner.ownerName = name;
    }

    /**
     *@dev withMinValue check if is sended the min value of ether
     *@param minValue minimun value of ether
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
    function getCount() public view returns (uint16) {
        return prizeDrawCount;
    }

    /**
     *@dev getOwner return the address of the owner
     */
    function getOwner() public view returns (address) {
        return owner.ownerAddress;
    }

    /**
     *@dev fetOwnerRich return the value of richOwner (true or false)
     */
    function fetOwnerRich() public view returns (bool) {
        return owner.richOwner;
    }

    /**
     * @dev invalidateContract destroy this contract
     **/
    function invalidateContract() public {
        require(
            msg.sender == owner.ownerAddress,
            "Only owner can destroy this contract"
        );

        selfdestruct(payable(owner.ownerAddress));
    }

    function getRealatory()
        public
        view
        returns (
            bool _richOwner,
            address _owner,
            uint16 _priceDrawCount,
            uint256 _prizeDrawNumber,
            address _thisAddress,
            uint256 _balance,
            uint256 _blockTimestamp,
            string memory _ownerName,
            uint16[] memory _numbersDrawn
        )
    {
        return (
            owner.richOwner,
            owner.ownerAddress,
            prizeDrawCount,
            prizeDrawNumber,
            address(this),
            address(this).balance,
            block.timestamp,
            owner.ownerName,
            numbersDrawn
        );
    }
}
