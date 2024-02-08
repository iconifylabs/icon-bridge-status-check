const hre = require("hardhat");

async function main() {
  provider = new hre.ethers.providers.JsonRpcProvider(hre.network.config.url)
  tx = await provider.getTransactionReceipt('0x56fc9184a01b4c8ff0c2f46ac81db26aeba81ead99f8d31f46050cd064d1c856')

  // might change the index based on number of logs a transaction has. This is for TransferStart event which is at 1st index of eventlog array
  log = tx.logs[1] 


  // Change the ABI event signature
  // const ABI = ["event TransferStart(address indexed _from, string _to, uint256 _sn, _assetDetails (string coinName, uint256 value,uint256 fee)[])"]
  const ABI = ["event Message(string _next, uint256 _seq, bytes _msg)"]
  let iface = new hre.ethers.utils.Interface(ABI);
  a = iface.parseLog(log)
  console.log(a.args)
}


main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});