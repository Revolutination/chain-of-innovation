const { ethers } = require("ethers");
const TransactionPool = require("./TransactionPool");

class TransactionManager {
    constructor(provider, transactionPool) {
        this.provider = provider;
        this.transactionPool = transactionPool;
    }

    async createTransaction(sender, receiver, amount, gasLimit) {
        const transaction = {
            from: sender,
            to: receiver,
            value: ethers.utils.parseEther(amount.toString()),
            gasLimit: gasLimit,
            nonce: await this.provider.getTransactionCount(sender),
            chainId: await this.provider.getNetwork().then(network => network.chainId),
        };

        const signedTransaction = await this.signTransaction(sender, transaction);
        this.transactionPool.addTransaction(signedTransaction);
        return signedTransaction;
    }

    async signTransaction(sender, transaction) {
        const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, this.provider);
        return await wallet.signTransaction(transaction);
    }

    async processTransactions() {
        const transactions = this.transactionPool.getPendingTransactions();
        for (const tx of transactions) {
            try {
                const txResponse = await this.provider.sendTransaction(tx);
                console.log(`Transaction sent: ${txResponse.hash}`);
                await txResponse.wait();
                console.log(`Transaction confirmed: ${txResponse.hash}`);
                this.transactionPool.removeTransaction(tx.hash);
            } catch (error) {
                console.error(`Transaction failed: ${error.message}`);
            }
        }
    }
}

module.exports = TransactionManager;
