# Advanced Keras

![overview](https://i.imgur.com/uy3mgL5.png)

![overview2](https://i.imgur.com/wqn6ZCx.png)

![overview3](https://i.imgur.com/fpJcEYW.png)

![overview4](https://i.imgur.com/4Upn06r.png)

## Input tensor vs output layer

The Input function returns a "tensor." If you print this tensor, you'll see that it is a tf.Tensor object, which indicates it is ready to be used by our model as input.

![it](https://i.imgur.com/ZTA6VNJ.png)

Now that we've defined our input layer, let's define the output layer. Outputs in keras are most commonly a single dense layer, which specifies the shape of the expected output. In this case, we are expecting our model to predict a single value, so we pass one unit to the dense layer.

![ol](https://i.imgur.com/xUVdiMX.png)

If you print the output layer, the result is NOT a tensorflow tensor. It is a function, which takes a tensor as input and produces a tensor as output. The difference between layers and tensors is key to understanding the keras functional API. Layers are used to construct a deep learning model, and tensors are used to define the data flow through the model. 

![itol](https://i.imgur.com/57IhTeC.png)

# Categorical Embeddings

Categorical embeddings are an advanced type of layer, only available in deep learning libraries. They are extremely useful for dealing with high cardinality categorical data. In this dataset, the team ID variable has high cardinality. Embedding layers are also very useful for dealing with text data, such as in Word2vec models, but that is beyond the scope of this course. To model these teams in the basketball data, you'll use a very simple model that learns a "strength" rating for each team and uses those ratings to make predictions. To map the integer team IDs to a decimal rating, we will use an embedding layer. 
![catemb1](https://i.imgur.com/PpUY0fD.png)

![catemb2](https://i.imgur.com/MmnFwcn.png)

Embedding layers increase the dimensionality of your data. The input CSV has two dimensions (rows and columns), but embedding layers add a third dimension. This third dimension can be useful when dealing with images and text, so it is not as relevant to this course. Therefore, we use the flatten layer to flatten the embeddings from 3D to 2D. The flatten layer is also the output layer for the embedding process. Flatten layers are an advanced layer for deep learning models and can be used to transform data from multiple dimensions back down to two dimensions. They are useful for dealing with time series data, text data, and images. 

![catemb4](https://i.imgur.com/ItQwWR1.png)

Now you can wrap your embedding layer in a model. This will allow you to reuse the model for multiple inputs in the dataset. You do this by defining an input layer, then an embedding layer, then a flatten layer for the output. Finally, wrap the input tensor and flatten tensor in a model. **This model can be treated exactly the same as a layer, and re-used inside of another model.**

# Shared layers

![shlay1](https://i.imgur.com/WD3xR0p.png)


Recall the category embedding model we made in the previous lesson. This model first embeds an input and then flattens it. You can also share models, not just layers. This is really cool and is part of what makes the functional API so useful. You can define modular components of models and then reuse them. We define an embedding layer and wrap it in a model. We then define 2 input tensors, and pass each one to the same model, producing 2 output tensors. This will use the same model, with the same layers and the same weights, for mapping each input to its corresponding output. 
![shlay2](https://i.imgur.com/g6DRtx3.png)

```python
# Load the input layer from keras.layers
from keras.layers import Input

# Input layer for team 1
team_in_1 = Input((1,), name= "Team-1-In")

# Separate input layer for team 2
team_in_2 = Input((1,), name = "Team-2-In")

# Lookup team 1 in the team strength model
team_1_strength = team_strength_model(team_in_1)

# Lookup team 2 in the team strength model
team_2_strength = team_strength_model(team_in_2)
```

# Merge Layers

* Add
* Subtract
* Multiply
* Concatenate (np.hstack)

![mergeadd](https://i.imgur.com/61eIhQD.png)

```python
# Import the Subtract layer from keras
from keras.layers import Subtract

# Create a subtract layer using the inputs from the previous exercise
score_diff = Subtract()([team_1_strength, team_2_strength])
```

Model using two inputs and one output

Now that you have your two inputs (team id 1 and team id 2) and output (score difference), you can wrap them up in a model so you can use it later for fitting to data and evaluating on new data.

Your model will look like the following diagram:
![mergelayers]( https://s3.amazonaws.com/assets.datacamp.com/production/course_6554/datasets/basketball_model_2.png)

# Multiple Input notes

![mi1](https://i.imgur.com/NRedmVj.png)


To make predictions from a model with two inputs, you also need to provide two inputs to the model's predict() method, again as a list. In this case, I've defined a model that adds numbers. So in order to add 1 and 2, first convert 1 and 2 into 2D numpy arrays. Then pass 1 as the first input, and 2 as the second input. The model outputs 3. Note that the data type of the output is float32. You can also add other numbers with this simple model, e.g. 42 and 119. Which add up to 161.

![mi2](https://i.imgur.com/Yqu0OcE.png)

# Three Inputs

![tin1](https://i.imgur.com/dCiQMBp.png)

![tin2](https://i.imgur.com/5BFkk3v.png)

![tin3](https://i.imgur.com/JdLbD9W.png)

![tin4](https://i.imgur.com/q7xFrOH.png)

```python
# Create an Input for each team
team_in_1 = Input(shape=(1,), name='Team-1-In')
team_in_2 = Input(shape=(1,), name='Team-2-In')

# Create an input for home vs away
home_in = Input(shape=(1,), name='Home-In')

# Lookup the team inputs in the team strength model
team_1_strength = team_strength_model(team_in_1)
team_2_strength = team_strength_model(team_in_2)

# Combine the team strengths with the home input using a Concatenate layer, then add a Dense layer
out = Concatenate()([team_1_strength, team_2_strength, home_in])
out = Dense(1)(out)

# Import the model class
from keras.models import Model

# Make a Model
model = Model([team_in_1, team_in_2, home_in], out)

# Compile the model
model.compile(optimizer='adam', loss='mean_absolute_error')

# Fit the model to the games_season dataset
model.fit([games_season['team_1'], games_season['team_2'], games_season['home']],
          games_season['score_diff'],
          epochs=1,
          verbose=True,
          validation_split=0.1,
          batch_size=2048)

# Evaluate the model on the games_tourney dataset
print(model.evaluate([games_tourney['team_1'], games_tourney['team_2'],
                        games_tourney['home']], games_tourney['score_diff'], verbose=False))
```

# Summary and Plot

Here is the summary for a Keras model. The summary shows you all the layers in the model, as well as how many parameters each layer has. Importantly, Keras models can have non-trainable parameters that are fixed and do not change, as well as trainable parameters, that are learned from the data when the model is fit. Models with more trainable parameters are typically more flexible. This can also make them more prone to overfitting. Models with fewer trainable parameters are less flexible, but therefore less likely to overfit. In this case, the model has three inputs. Since all three of them feed into one Dense layer, the model has four parameters: one per input plus a bias, or intercept. All of these parameters are trainable. A model's trainable parameters are usually in its Dense layers. 
![sum1](https://i.imgur.com/B1kWczp.png)


# Stacking Models

![stack1](https://i.imgur.com/xphNQto.png)

# Two Outputs

![tout1](https://i.imgur.com/mwrXa9G.png)

# Regressor and Classifier Model

![clfreg1](https://i.imgur.com/IIwHtEJ.png)

![clfreg2](https://i.imgur.com/NRCW6BN.png)

![clfreg3](https://i.imgur.com/iRzj16N.png)

inally, you can evaluate the model on new data. First, split the evaluation dataset into a regression target and a classification target, and provide the same list of 2 targets to the evaluate() method. This outputs 3 numbers now, instead of 1 as with the models we looked at in other chapters. The first number is the loss function used by the model, which is the sum of all the output losses. The second number is the loss for the regression part of the model, and the third number is the loss for the classification part of the model. So our model has a mean absolute error of 9.28 and a logloss of 0.58, which is pretty good, but I think you can do better with more data when you try for yourself.

![clfreg4](https://i.imgur.com/uk0fAk7.png)