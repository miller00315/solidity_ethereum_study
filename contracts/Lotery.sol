// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

struct OwnerStruct {
    address ownerAddress;
    string ownerName;
    bool richOwner;
}

struct DrawStruct {
    uint256 date;
    uint256 prizeDrawNumber;
    address sender;
}

contract Lottery {
    OwnerStruct private owner;
    DrawStruct[] private numbersDrawn;
    address[] private winners;
    uint256 totalAward;

    constructor(uint256 initialValue) {
        require(msg.sender.balance >= 99 ether);

        owner = OwnerStruct(msg.sender, "", msg.sender.balance > 20);

        DrawStruct memory draw =
            DrawStruct(block.timestamp, initialValue, msg.sender);

        numbersDrawn.push(draw);
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
     *@dev onlyOwnerPermision check if the user is the contract owner
     */
    modifier onlyOwnerPermission() {
        require(
            msg.sender == owner.ownerAddress,
            "Only the contract's owner can set the value"
        );
        _;
    }

    event SendedAmount(address payAddress, uint256 amount);

    /**
     *@dev set the prizeDrawNumber
     *@param sended new value of prizeDrawNumber
     */
    function set(uint16 sended)
        public
        payable
        withMinValue(1000)
        onlyOwnerPermission()
    {
        DrawStruct memory draw =
            DrawStruct(block.timestamp, sended, msg.sender);

        numbersDrawn.push(draw);

        if (msg.value > 1000) {
            uint256 amount = msg.value - 1000;

            // Set a payable addres to send a value
            payable(address(uint160(msg.sender))).transfer(amount);

            emit SendedAmount(msg.sender, amount);
        }
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
     *@dev getPrizeDrawNumber return the current value of prizeDrawNumber
     */
    function getLastPrizeDrawNumber() public view returns (uint256) {
        return numbersDrawn[numbersDrawn.length - 1].prizeDrawNumber;
    }

    /**
     *@dev getCount return the count of preize draw
     */
    function getCount() public view returns (uint256) {
        return numbersDrawn.length;
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

    function distibuteAward()
        public
        returns (
            uint256 _individualAward,
            uint256 _remainingAward,
            uint256 _sendedAward
        )
    {
        if (winners.length > 0) {
            uint256 individualAward = totalAward / winners.length;
            uint256 remainingAward = totalAward;
            uint256 sendedAward = 0;

            for (uint256 position = 0; position < winners.length; position++) {
                payable(address(uint160(winners[position]))).transfer(
                    individualAward
                );
                remainingAward = remainingAward - individualAward;
                sendedAward = sendedAward + individualAward;
            }

            return (individualAward, remainingAward, sendedAward);
        }

        return (0, totalAward, 0);
    }

    function getRealatory()
        public
        view
        returns (
            bool _richOwner,
            address _owner,
            uint256 _priceDrawCount,
            uint256 _prizeDrawNumber,
            address _thisAddress,
            uint256 _balance,
            uint256 _blockTimestamp,
            string memory _ownerName,
            DrawStruct[] memory _numbersDrawn,
            uint256 _lastDate
        )
    {
        return (
            owner.richOwner,
            owner.ownerAddress,
            numbersDrawn.length,
            numbersDrawn[numbersDrawn.length - 1].prizeDrawNumber,
            address(this),
            address(this).balance,
            block.timestamp,
            owner.ownerName,
            numbersDrawn,
            numbersDrawn[numbersDrawn.length - 1].date
        );
    }
}
