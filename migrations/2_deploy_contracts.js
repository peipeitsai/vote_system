const init_Voting = artifacts.require("./contract/init_Voting");

module.exports = function (deployer) {
    deployer.deploy(init_Voting,"-----BEGIN PUBLIC KEY-----@MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAcnHeo51yX3UYeWbjEbdsgfPP@SSp3ZnEnJbqhdgUDrLRcgN4RXZVRFpboGAcR143cYMmTgP2Ecw3EbQ97/oP7ycoH@8MNRBH0PaIBEWKwa3QmcynzptyundKPk4f92A/noKUQMVbZinGXv8Zk+OfOlk19M@JFoRFwdzCoYK8zdIiQIDAQAB@-----END PUBLIC KEY-----","President",["Chen","Lu","Yang"],[2022,9,1,0,0,0,12,30,21,0,0,9,1,0,0,0,12,31,21,0,0],"總統大選,得由全國人民選舉之,以候選人得票數較多者為當選,可以連任。",["花市大學博士畢業","曾任花花市長秘書","現任花花市府發言人"]);
};