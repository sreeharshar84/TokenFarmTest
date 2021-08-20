require('babel-register');
require('babel-polyfill');
const HDWalletProvider = require('@truffle/hdwallet-provider')
require('dotenv').config()

const mnemonic = process.env.MNEMONIC
const urlKovan = process.env.RPC_URL
const urlRinkeby = process.env.RPC_URL_RINKEBY
const urlMumbai = process.env.RPC_URL_MUMBAI

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    kovan: {
      provider: () => {
        return new HDWalletProvider(mnemonic, urlKovan)
      },
      network_id: '42',
      skipDryRun: true
    },
    rinkeby: {
      provider: () => {
        return new HDWalletProvider(mnemonic, urlRinkeby)
      },
      network_id: '4',
      gas: 4500000,
      gasPrice: 1000000000,
    },
    mumbai: {
      provider: () => {
        return new HDWalletProvider(mnemonic, urlMumbai)
      },
      network_id: '80001',
      skipDryRun: true
    },
  },

  contracts_directory: './src/contracts/',
  contracts_build_directory: './src/abis/',
  compilers: {
    solc: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion: "petersburg"
    }
  }
}
