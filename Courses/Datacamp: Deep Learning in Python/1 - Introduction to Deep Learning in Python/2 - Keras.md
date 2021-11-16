# Intro to Keras

- [Intro to Keras](#intro-to-keras)
  - [Specificating a model](#specificating-a-model)
  - [Compile model](#compile-model)
  - [Mumbo Jumbo](#mumbo-jumbo)
  - [Classification](#classification)
  - [Save, Load and Predict](#save-load-and-predict)
  - [Model Optimization](#model-optimization)
    - [Optimizers](#optimizers)
  - [Early stopping](#early-stopping)
  - [An almost complete boilerplate](#an-almost-complete-boilerplate)
- [Estimators API](#estimators-api)

## Specificating a model

![](https://i.imgur.com/DUldLM0.png)

Sequential model is the simplest type of model.

Dense because the notes of layer 1 connect to all nodes in layer 2.

My second Keras model  
```python
# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential

# Save the number of columns in predictors: n_cols
n_cols = predictors.shape[1]

# Set up the model: model
model = Sequential()

# Add the first layer
model.add(Dense(50, activation='relu', input_shape=(n_cols,)))

# Add the second layer
model.add(Dense(32, activation='relu'))

# Add the output layer
model.add(Dense(1))
```

## Compile model

![](https://i.imgur.com/C6iB40A.png)

![](https://i.imgur.com/gBjgZNO.png)

![](https://i.imgur.com/cPasrcS.png)

## Mumbo Jumbo

```python
# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential

# Specify the model
n_cols = predictors.shape[1]
model = Sequential()
model.add(Dense(50, activation='relu', input_shape = (n_cols,)))
model.add(Dense(32, activation='relu'))
model.add(Dense(1))

# Compile the model
model.compile(optimizer='adam', loss='mean_squared_error')

# Fit the model
model.fit(predictors, target)
```

## Classification

![](https://i.imgur.com/afa5uey.png)

![](https://i.imgur.com/LQ1hUac.png)

The code implementation
```python
# Import necessary modules
import keras
from keras.layers import Dense
from keras.models import Sequential
from keras.utils import to_categorical

# Convert the target to categorical: target
target = to_categorical(df.survived)

# Set up the model
model = Sequential()

# Add the first layer
model.add(Dense(32, activation = 'relu', input_shape=(n_cols,)))

# Add the output layer
model.add(Dense(2, activation = 'softmax'))

# Compile the model
model.compile(optimizer = 'sgd', 
                loss='categorical_crossentropy',
                metrics=['accuracy'])

# Fit the model
model.fit(predictors, target)

# Calculate predictions: predictions
predictions = model.predict(pred_data)

# Calculate predicted probability of survival: predicted_prob_true
predicted_prob_true = predictions[:,1]

# print predicted_prob_true
print(predicted_prob_true)
```

## Save, Load and Predict

![](https://i.imgur.com/5OfE3ic.png)


## Model Optimization

![](https://i.imgur.com/X1UG4HZ.png)

Dead Neuron problem -> Change activation function might solve the problem.


### Optimizers

```python
# Import the SGD optimizer
from keras.optimizers import SGD

# Create list of learning rates: lr_to_test
lr_to_test = [.000001, .01, 1]

# Loop over learning rates
for lr in lr_to_test:
    print('\n\nTesting model with learning rate: %f\n'%lr )
    
    # Build new model to test, unaffected by previous models
    model = get_new_model()
    
    # Create SGD optimizer with specified learning rate: my_optimizer
    my_optimizer = SGD(lr=lr)
    
    # Compile the model
    model.compile(optimizer = my_optimizer, loss = 'categorical_crossentropy')
    
    # Fit the model
    model.fit(predictors, target)
```

If I want to do a train/dev split:   
`hist = model.fit(predictors, target, validation_split = 0.3)`

## Early stopping

![](https://i.imgur.com/RZ3Wl1k.png)

```python
# Import EarlyStopping
from keras.callbacks import EarlyStopping

# Save the number of columns in predictors: n_cols
n_cols = predictors.shape[1]
input_shape = (n_cols,)

# Specify the model
model = Sequential()
model.add(Dense(100, activation='relu', input_shape = input_shape))
model.add(Dense(100, activation='relu'))
model.add(Dense(2, activation='softmax'))

# Compile the model
model.compile(optimizer = 'adam',
                loss = 'categorical_crossentropy',
                metrics = ['accuracy'])

# Define early_stopping_monitor
early_stopping_monitor = EarlyStopping(patience = 2)

# Fit the model
model.fit(predictors, target, epochs = 30, validation_split = 0.3,
            callbacks = [early_stopping_monitor])
```


## An almost complete boilerplate

```python
# Define early_stopping_monitor
early_stopping_monitor = EarlyStopping(patience=2)

# Create the new model: model_2
model_2 = Sequential()

# Add the first and second layers
model_2.add(Dense(100, activation='relu', input_shape=input_shape))
model_2.add(Dense(100, activation='relu', input_shape=input_shape))

# Add the output layer
model_2.add(Dense(2, activation = 'softmax'))

# Compile model_2
model_2.compile(optimizer = 'adam', loss = 'categorical_crossentropy', metrics=['accuracy'])

# Fit model_1
model_1_training = model_1.fit(predictors, target, epochs=15, validation_split=0.2, callbacks=[early_stopping_monitor], verbose=False)

# Fit model_2
model_2_training = model_2.fit(predictors, target, epochs=15, validation_split=0.2, callbacks=[early_stopping_monitor], verbose=False)

# Create the plot
plt.plot(model_1_training.history['val_loss'], 'r', model_2_training.history['val_loss'], 'b')
plt.xlabel('Epochs')
plt.ylabel('Validation score')
plt.show()
```


# Estimators API

![EAPI](https://i.imgur.com/P1IjvvF.png)

![dfcolumns](https://i.imgur.com/w5uQUR1.png)

![dfcolumns2](https://i.imgur.com/MnrJuvR.png)

![etl](https://i.imgur.com/tCXAife.png )

![auto](https://i.imgur.com/bPl04Bg.png)

Or DNNClassifier