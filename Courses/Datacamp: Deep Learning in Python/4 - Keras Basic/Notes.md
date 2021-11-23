# Keras


# Callbacks

 They are useful to store metrics as the model trains and to make decisions as the training goes by.

 ![callbacks1](https://i.imgur.com/GqgprJS.png)


 ![callbacks2](https://i.imgur.com/KFbNceH.png)

 ![callbacks3](https://i.imgur.com/YunRvNO.png)

 ![callbacks4](https://i.imgur.com/Vyx6kj1.png)

 ![callbacks5](https://i.imgur.com/nL3FfBy.png)


 # Learning Curves

The curves seen so far are the `loss` and `accuracy` curves

![curves1](https://i.imgur.com/7dLT2Vb.png)

![curves2](https://i.imgur.com/LqODBW1.png)


# Activations

![Activ1](https://i.imgur.com/CRwh6GC.png)

![activ2](https://i.imgur.com/OonDB1B.png)

![activSave](https://i.imgur.com/4HiFKqS.png)

# Access model layers

![access1](https://i.imgur.com/JLfbjRs.png)

![access2](https://i.imgur.com/EiHJEgW.png)

If we import the Keras backend we can build a function that takes in an input tensor from a given layer and returns an output tensor from another or the same layer. Tensorflow is the backend Keras is using in this course, but it could be any other, like Theano. To define the function with our backend K we need to give it a list of inputs and outputs, even if we just want 1 input and 1 output. Then we can use it on a tensor with the same shape as the input layer given during its definition. If the weights of the layers between our input and outputs change the function output for the same input will change as well. We can use this to see the output of certain layers as weights change during training.

# Pre-trained models (ResNet50)

![resnet1](https://i.imgur.com/f306K8Y.png)

![resnet2](https://i.imgur.com/FVMiw1a.png)

# RNN & LSTM

![rnn1](https://i.imgur.com/st4sHA5.png)

![ltsmcell](https://i.imgur.com/wDAxB9s.png)

![ltsmmodel](https://i.imgur.com/72SRu0j.png)

# Word Tokenizer

We first define some text and choose a sequence length. With a sequence length of 3 we will end up feeding our model with two words and it will predict the third one. We split the text into words with the split method. The output looks like this: We then need to turn these words into consecutive lines of 3 words each. We can loop from seq_len to the number of words + 1 and store each line. The end results look like this: 
![token1](https://i.imgur.com/XngJyxV.png)

After that we turn our text sequences into numbers. We import Keras Tokenizer from the preprocessing text module. Instantiate it, fit it on lines,and then turn those lines into numeric sequences. This is how the 3-word lines look now. The tokenizer object stores the word-to-number mapping. There are two dictionaries, the index_word, and the word_index. Here, the index_word is printed, which shows the encoded word for each index. We can use this dictionary to decode our outputs, mapping numbers to words. 
![token2](https://i.imgur.com/44ABQHA.png)