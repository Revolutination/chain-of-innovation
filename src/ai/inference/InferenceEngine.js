const NeuralNetwork = require('../models/NeuralNetwork');

class InferenceEngine {
    constructor(modelPath) {
        this.model = null;
        this.loadModel(modelPath);
    }

    async loadModel(modelPath) {
        this.model = await tf.loadLayersModel(`file://${modelPath}/model.json`);
        console.log('Model loaded successfully.');
    }

    predict(input) {
        const prediction = this.model.predict(tf.tensor(input)).arraySync();
        return prediction;
    }
}

module.exports = InferenceEngine;
