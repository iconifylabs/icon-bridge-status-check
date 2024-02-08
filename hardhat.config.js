require("@nomiclabs/hardhat-waffle");

// get contract addresses and rpc endpoint from networks
const SNOW = require("./config/SNOW.json")
const BSC = require("./config/BSC.json")
const BSC_TESTNET = require("./config/BSC_TESTNET.json")
const ARCTIC = require("./config/ARCTIC.json")

task("contract", "Interact with contract")
  .addParam("cname", "Contract name")
  .addOptionalParam("token", "Is Token?")
  .setAction(async (taskArgs, a) => {
    const network = a.hardhatArguments.network.toUpperCase();
    let contracts = getContacts(network);

    const contractName = taskArgs.cname;
    const contractAddr = contracts[contractName];

    if (taskArgs.token == "yes") {

      const Contract = await hre.ethers.getContractFactory("ERC20Tradable");
      const contract = Contract.attach(contractAddr);

      // change the name of method here: await contract.methodName()
      // if parameters required: await contract.methodName(param1, param2...);
      const returnedData = await contract.name();
      
      log(returnedData);

    } else {

      const Contract = await hre.ethers.getContractFactory(contractName);
      const contract = Contract.attach(contractAddr);

      // change the name of method here: await contract.methodName()
      // if parameters required: await contract.methodName(param1, param2...);
      const returnedData = await contract.getNativeCoinName();
      
      log(returnedData);
    }
  });

const log = (...message) => {
  console.log("\n");
  console.log("[-----------", ...message, "-----------]");
  console.log("\n");
};

const getContacts = (network) => {
  if (network == "SNOW") {
    return SNOW.contract;
  } else if (network == "BSC") {
    return BSC.contract;
  } else if (network == "BSC_TEST") {
    return BSC_TESTNET.contract;
  } else {
    log("Invalid network");
    exit(0);
  }
};

module.exports = {
  solidity: "0.8.4",
  defaultNetwork: "bsc",
  networks: {
    hardhat: {},
    snow: {
      url: SNOW.network.uri,
      accounts: [
        "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
      ],
    },
    bsc: {
      url: BSC.network.uri,
      accounts: [
        "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
      ],
    },
    bsc_test: {
      url: BSC_TESTNET.network.uri,
      accounts: [
        "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
      ],
    },
    arctic: {
      url: ARCTIC.network.uri,
      accounts: [
        "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
      ],
      // gas: 9000000,
      gasPrice: 20000000000,
    },
  },
};
