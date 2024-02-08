require("hardhat");

const SNOW = require("../config/SNOW.json");
const BSC = require("../config/BSC.json");
const BSC_TESTNET = require("../config/BSC_TESTNET.json");
const ARCTIC = require("../config/ARCTIC.json");

const DEST_ADDR = "btp://0x2.icon/hx1637472e23df38a3b90d644017d0c4c973142e72";

const getContacts = (network) => {
  if (network == "SNOW") {
    return SNOW.contract;
  } else if (network == "BSC") {
    return BSC.contract;
  } else if (network == "BSC_TEST") {
    return BSC_TESTNET.contract;
  } else if (network == "ARCTIC") {
    return ARCTIC.contract;
  } else {
    log("Invalid network");
    exit(0);
  }
};

const toWei = (number) => hre.ethers.utils.parseEther(number.toString());

const txLog = async (tx) => {
  if (tx === null) {
    return 0;
  }
  let txn = await tx.wait();
  console.log(txn);
};

async function main() {

  const addr = ''

  let contracts = getContacts(hre.network.name.toUpperCase());
  let tx;

  const Contract = await hre.ethers.getContractFactory("BMCPeriphery");
  const btscore = await Contract.attach(contracts.BMCPeriphery);

  var status = await btscore.getStatus("btp://0x1.icon/cx23a91ee3dd290486a9113a6a42429825d813de53");
  const colorYellow='\033[0;33m'
  const colorReset='\033[0m'

  // console.log(status)
console.log(`${colorYellow}BSC Side: ${colorReset}`);
console.log(`${colorYellow}    Rx Sequence : ${status.rxSeq.toString()} ${colorReset}`);
console.log(`${colorYellow}    Tx Sequence : ${status.txSeq.toString()} ${colorReset}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

