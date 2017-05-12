#/bin/bash
rpcpassword=$(cat /etc/bitcoin/bitcoin.conf | grep rpcpassword | cut -d '=' -f2)
rpcuser=$(cat /etc/bitcoin/bitcoin.conf | grep rpcuser | cut -d '=' -f2)

blockheight=$(/usr/local/bin/bitcoin-cli -rpcuser=$rpcuser -rpcpassword=$rpcpassword getblockcount)

echo "Current height: $blockheight"

currentmaxblock=$(/usr/local/bin/bitcoin-cli -rpcuser=$rpcuser -rpcpassword=$rpcpassword getexcessiveblock | grep excessiveBlockSize | grep -o [0-9]*)
currentminedblock=$(/usr/local/bin/bitcoin-cli -rpcuser=$rpcuser -rpcpassword=$rpcpassword getminingmaxblock)

if [ "$blockheight" -ge "488888" ]; then
    if [ "$currentmaxblock" -lt "8000000" ]; then
        /usr/local/bin/bitcoin-cli -rpcuser=$rpcuser -rpcpassword=$rpcpassword setexcessiveblock 8000000 12
	# If you have a script for changing the coinbase message, set it here
    fi
    if [ "$currentminedblock" -lt "8000000" ]; then
        /usr/local/bin/bitcoin-cli -rpcuser=$rpcuser -rpcpassword=$rpcpassword setminingmaxblock 8000000
	# If you have a script for changing the coinbase message, set it here
    fi
fi
