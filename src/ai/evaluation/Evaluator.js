const tf = require('@tensorflow/tfjs');

class Evaluator {
    constructor(model) {
        this.model = model;
    }

    evaluate(xTest, yTest) {
        const results = this.model.evaluate(xTest, yTest);
        console.log(`Test Loss: ${results[0].dataSync()[0]}, Test Accuracy: ${results[1].dataSync()[0]}`);
        return {
            loss: results[0].dataSync()[0],
            accuracy: results[1].dataSync()[0],
        };
    }

    confusionMatrix(yTrue, yPred) {
        const cm = tf.math.confusionMatrix(yTrue, yPred);
        console.log('Confusion Matrix:');
        cm.print();
        return cm;
    }
}

module.exports = Evaluator;
