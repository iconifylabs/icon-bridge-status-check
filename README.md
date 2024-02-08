## ICON Bridge Solidity Contract Interaction 


1. Paste all the contracts you need to interact with in solidity folder of icon-bridge in `contracts/` directory. Currently, all the required contracts of icon bridge are already in contracts folder.

2. Install node modules and compile solidity contracts.
	```sh
	yarn
	# or npm install


	npx hardhat compile
	```

3. `config/` directory has contract addresses and RPC endpoints of all BSC mainnet `(BSC.json)`, BSC testnet `(BSC_TESTNET.json)` and SNOW mainnet `(SNOW.json)`/

4. `hardhat.config.js` uses these contract addresses and abi generated after compilation, to interact with the contracts.

5. Run the icon-bridge-stat.sh script. It requires goloop cli for fetching data from ICON Chain. 

## For other interaction. 
1. To interact with token contract:
	```sh
	npx hardhat contract --network bsc --token yes --cname ICX
	```
	
	The flag `--token yes` will be used to confirm if it is token<p>
	The flag `--cname ICX` indicates the contract to interact with is `ICX` contract on the `bsc` network. The address of the contract is on `config/BSC.json`

	In line number 25 of `hardhat.config.json`, change the method name, if any other method is to be called. Pass arguments if any.

2. To interact with non-token contracts:
	```sh
	npx hardhat contract --network bsc --cname BTSCore
	```
	The `flag --token` is not required
	The `flag --cname BTSCore`, indicates the contract to interact with is `BTS Core` contract.

	In line number 36 of `hardhat.config.json`, change the method name with required method to be called. Pass arguments if any.

3. The networks can be
	```
	bsc 		: BSC Mainnet
	bsc_test	: BSC Testnet
	snow		: SNOW Mainnet
	arctic		: ARCTIC Testnet
	```
	Other networks have not been configured.