const NeuralNetwork = require('../models/NeuralNetwork');

class Trainer {
    constructor(inputShape, outputShape) {
        this.model = new NeuralNetwork(inputShape, outputShape);
    }

    async trainModel(xTrain, yTrain, epochs, batchSize) {
        console.log('Starting training...');
        await this.model.train(xTrain, yTrain, epochs, batchSize);
        console.log('Training completed.');
    }

    saveModel(path) {
        return this.model.model.save(`file://${path}`);
    }
}

module.exports = Trainer;
