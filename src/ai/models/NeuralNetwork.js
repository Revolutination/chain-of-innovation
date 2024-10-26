const tf = require('@tensorflow/tfjs');

class NeuralNetwork {
    constructor(inputShape, outputShape) {
        this.model = this.createModel(inputShape, outputShape);
    }

    createModel(inputShape, outputShape) {
        const model = tf.sequential();
        model.add(tf.layers.dense({ units: 64, activation: 'relu', inputShape }));
        model.add(tf.layers.dense({ units: 32, activation: 'relu' }));
        model.add(tf.layers.dense({ units: outputShape, activation: 'softmax' }));
        model.compile({
            optimizer: tf.train.adam(),
            loss: 'categoricalCrossentropy',
            metrics: ['accuracy'],
        });
        return model;
    }

    async train(xTrain, yTrain, epochs = 50, batchSize = 32) {
        return await this.model.fit(xTrain, yTrain, {
            epochs,
            batchSize,
            callbacks: {
                onEpochEnd: (epoch, logs) => {
                    console.log(`Epoch ${epoch + 1}: loss = ${logs.loss}, accuracy = ${logs.acc}`);
                },
            },
        });
    }

    predict(input) {
        return this.model.predict(tf.tensor(input)).arraySync();
    }
}

module.exports = NeuralNetwork;
