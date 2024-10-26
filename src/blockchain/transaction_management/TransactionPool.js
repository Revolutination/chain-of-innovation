class TransactionPool {
    constructor() {
        this.transactions = {};
    }

    addTransaction(transaction) {
        const txHash = this.getTransactionHash(transaction);
        if (!this.transactions[txHash]) {
            this.transactions[txHash] = transaction;
            console.log(`Transaction added to pool: ${txHash}`);
        } else {
            console.log(`Transaction already exists in pool: ${txHash}`);
        }
    }

    removeTransaction(txHash) {
        if (this.transactions[txHash]) {
            delete this.transactions[txHash];
            console.log(`Transaction removed from pool: ${txHash}`);
        }
    }

    getPendingTransactions() {
        return Object.values(this.transactions);
    }

    getTransactionHash(transaction) {
        return ethers.utils.keccak256(ethers.utils.defaultAbiCoder.encode(
            ["address", "address", "uint256", "uint256", "uint256", "uint256"],
            [transaction.from, transaction.to, transaction.value, transaction.gasLimit, transaction.nonce, transaction.chainId]
        ));
    }
}

module.exports = TransactionPool;
