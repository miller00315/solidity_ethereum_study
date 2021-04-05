
const Lottery = artifacts.require("Lottery");

contract('MetaCoin', (accounts) => {
    it('should configure initial', async () => {
        const lotteryInstance = await Lottery.deployed();

        console.log(lotteryInstance)
    });
});
