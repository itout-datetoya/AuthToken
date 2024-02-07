/*
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const GOERLI_SCAN_APYKEY = process.env.GOERLI_SCAN_APYKEY;
*/

/** @type import('hardhat/config').HardhatUserConfig */
/*
module.exports = {
  solidity: "0.8.19",
  networks: {
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: GOERLI_SCAN_APYKEY
  },
};
*/


require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require('dotenv').config();

const PRIVATE_KEY = process.env.SCROLL_PRIVATE_KEY;
const SCROLL_RPC_URL = process.env.SCROLL_RPC_URL;


/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.19",
  networks: {
    scroll: {
      url: SCROLL_RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};

