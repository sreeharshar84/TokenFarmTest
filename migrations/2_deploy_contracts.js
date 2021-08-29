const TokenFarm = artifacts.require('TokenFarm')

module.exports = async function(deployer, network, accounts) {

  await deployer.deploy(TokenFarm)
  const tokenFarm = await TokenFarm.deployed();
}
