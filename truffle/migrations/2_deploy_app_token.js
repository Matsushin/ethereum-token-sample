var AppToken = artifacts.require("./AppToken.sol");

module.exports = function(deployer) {
    deployer.deploy(AppToken);
};
