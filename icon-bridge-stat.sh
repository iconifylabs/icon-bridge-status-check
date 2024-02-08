#!/bin/bash
#
colorRed='\033[0;31m'
colorGreen='\033[0;32m'
colorReset='\033[0m'
colorBlue='\033[0;34m'

# BSC Side

# echo "BSC Side 
npx hardhat run scripts/status_do_not_change.js --network bsc

#Icon Side
echo -e "${colorBlue}Icon Side:"
data=$(goloop rpc call --uri https://ctz.solidwallet.io/api/v3 \
    --to cx23a91ee3dd290486a9113a6a42429825d813de53 \
    --method getStatus \
    --param _link=btp://0x38.bsc/0x034AaDE86BF402F023Aa17E5725fABC4ab9E9798)

function hex2dec() {
    hex=${@#0x}
    echo "obase=10; ibase=16; ${hex^^}" | bc
}

# echo $data

rx_seq_hex=$(echo "$data" | jq -r '.rx_seq')
tx_seq_hex=$(echo "$data" | jq -r '.tx_seq')

echo "    Tx Sequence : " $(hex2dec $tx_seq_hex)
echo "    Rx Sequence : " $(hex2dec $rx_seq_hex)