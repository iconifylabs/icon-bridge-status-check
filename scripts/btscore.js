const hre = require("hardhat");

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
  console.log(hre.network.config.url);

  const addr = ''

  let contracts = getContacts(hre.network.name.toUpperCase());
  let tx;

  const Contract = await hre.ethers.getContractFactory("BMCPeriphery");
  const btscore = await Contract.attach(contracts.BTSCore);

  console.log(
    await btscore.balanceOf(
      addr,
      "btp-0x61.bsc-BNB"
    )
  );

  // let tx = await btscore.setFeeRatio("btp-0x229.snow-ICZ", 50, toWei(1));
  // txLog(tx);

  // console.log( await btscore.feeRatio('btp-0x229.snow-ICZ'))

  // const Token = await hre.ethers.getContractFactory("HRC20")
  // const token = await Token.attach(contracts.sICX)

  // let tx = await token.approve(btscore.address, toWei(80))
  // console.log(await tx.wait())



  // tx = await btscore.transfer('btp-0x2.icon-sICX',toWei(80), DEST_ADDR)
  // console.log(await tx.wait())



  // tx = await btscore.transferNativeCoin('btp://0x2.icon/hx91bf040426f226b3bfcd2f0b5967bbb0320525ce',{'value': hre.ethers.utils.parseEther("0.3")})
  // txLog(tx)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
