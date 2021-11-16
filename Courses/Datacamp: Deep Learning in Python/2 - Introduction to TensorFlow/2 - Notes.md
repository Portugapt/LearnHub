
# Input Data

## Setup data type

![](https://i.imgur.com/zjAizvL.png)

This will create a tensorflow object.

# Loss Function

![](https://i.imgur.com/px6SZZ6.png)

# Linear Regression

![](https://i.imgur.com/YAwgoxE.png)

![](https://i.imgur.com/phJfYm7.png)

# Batch Training

![](https://i.imgur.com/7FFZQ4H.png)

![](https://i.imgur.com/JmXnU7E.png)

This allows the load of thousands of gigabytes of data without exceeeding the memory.

In batch, we load the data during training?

# Dense layers

![](https://i.imgur.com/jjSV31W.png)

![](https://i.imgur.com/OZtOsIY.png)

![](https://i.imgur.com/ZZxI08y.png)

```python
# From previous step
bias1 = Variable(1.0)
weights1 = Variable(ones((3, 2)))
product1 = matmul(borrower_features, weights1)
dense1 = keras.activations.sigmoid(product1 + bias1)

# Initialize bias2 and weights2
bias2 = Variable(1.0)
weights2 = Variable(ones((2, 1)))

# Perform matrix multiplication of dense1 and weights2
product2 = matmul(dense1, weights2)

# Apply activation to product2 + bias2 and print the prediction
prediction = keras.activations.sigmoid(product2 + bias2)
print('\n prediction: {}'.format(prediction.numpy()[0,0]))
print('\n actual: 1')
```

# Activation Functions

* Sigmond
* Softmax
* ReLU

Refer to Course 1 notebooks.

# Optimizers

https://keras.io/api/optimizers/

* SGD (https://keras.io/api/optimizers/sgd/)
* RMS Prop (https://keras.io/api/optimizers/rmsprop/)
* Adam (https://keras.io/api/optimizers/adam/)

![Optim1](https://i.imgur.com/E3l0dZX.png)

## Dangers of local minima


```python
# Initialize x_1 and x_2
x_1 = Variable(6.0,float32)
x_2 = Variable(0.3,float32)

# Define the optimization operation
opt = keras.optimizers.SGD(learning_rate=0.01)

for j in range(100):
	# Perform minimization using the loss function and x_1
	opt.minimize(lambda: loss_function(x_1), var_list=[x_1])
	# Perform minimization using the loss function and x_2
	opt.minimize(lambda: loss_function(x_2), var_list=[x_2])

# Print x_1 and x_2 as numpy arrays
print(x_1.numpy(), x_2.numpy())
```

Output:
```
<script.py> output:
4.3801394 0.42052683
```

## Momentum

```python
# Initialize x_1 and x_2
x_1 = Variable(0.05,float32)
x_2 = Variable(0.05,float32)

# Define the optimization operation for opt_1 and opt_2
opt_1 = keras.optimizers.RMSprop(learning_rate=0.01, momentum=0.99)
opt_2 = keras.optimizers.RMSprop(learning_rate=0.01, momentum=0)

for j in range(100):
	opt_1.minimize(lambda: loss_function(x_1), var_list=[x_1])
    # Define the minimization operation for opt_2
	opt_2.minimize(lambda: loss_function(x_2), var_list=[x_2])

# Print x_1 and x_2 as numpy arrays
print(x_1.numpy(), x_2.numpy())
```

# Initialization of weights & Dropout

![WInit](https://i.imgur.com/wlESPyz.png)

![DOut](https://i.imgur.com/ZavTxio.png)

# Exercices 


* Initialize the layer 1 weights, w1, as a Variable() with shape [23, 7], drawn from a normal distribution.
* Initialize the layer 1 bias using ones.
* Use a draw from the normal distribution to initialize w2 as a Variable() with shape [7, 1].
* Define b2 as a Variable() and set its initial value to 0.0.


```python
# Define the layer 1 weights
w1 = Variable(random.normal([23, 7]))

# Initialize the layer 1 bias
b1 = Variable(ones([7]))

# Define the layer 2 weights
w2 = Variable(random.normal([7, 1]))

# Define the layer 2 bias
b2 = Variable(0.0)
```

* Apply a rectified linear unit activation function to the first layer.
* Apply 25% dropout to layer1.
* Pass the target, targets, and the predicted values, predictions, to the cross entropy loss function.


```python
# Define the model
def model(w1, b1, w2, b2, features = borrower_features):
	# Apply relu activation functions to layer 1
	layer1 = keras.activations.relu(matmul(features, w1) + b1)
    # Apply dropout rate of 0.25
	dropout = keras.layers.Dropout(0.25)(layer1)
	return keras.activations.sigmoid(matmul(dropout, w2) + b2)

# Define the loss function
def loss_function(w1, b1, w2, b2, features = borrower_features, targets = default):
	predictions = model(w1, b1, w2, b2)
	# Pass targets and predictions to the cross entropy loss
	return keras.losses.binary_crossentropy(targets, predictions)
```

## Training neural networks with TensorFlow

```python
# Train the model
for j in range(100):
    # Complete the optimizer
	opt.minimize(lambda: loss_function(w1, b1, w2, b2), 
                 var_list=[w1, b1, w2, b2])

# Make predictions with model using test features
model_predictions = model(w1, b1, w2, b2, test_targets)

# Construct the confusion matrix
confusion_matrix(test_targets, model_predictions)
```

Será que isto é bom para o Optune??

# Defining neural networks with Keras

![DefModelP1](https://i.imgur.com/fjlGBY6.png)

![DefModelP2](https://i.imgur.com/IWDXyOT.png)

## What if I want two NN's converging into one?

![ConvergeImg](https://i.imgur.com/KVwhBDu.png)

![Conv1](https://i.imgur.com/bMgF3FU.png)

![Conv2](https://i.imgur.com/xs7vKhH.png)

Code in Jupyter notebook