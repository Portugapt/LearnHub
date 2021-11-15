# What is a tensor?

> The TensorFlow documentation describes a tensor as "a generalization of vectors and matrices to potentially higher dimensions." 

![](https://i.imgur.com/1qrAkKd.png)

> As an example, let's say you have a slice of bread and you cut it into 9 pieces. One of those 9 pieces is a 0-dimensional tensor. This corresponds to a single number. A collection of 3 pieces that form a row or column is a 1-dimensional tensor. All 9 pieces together are a 2-dimensional tensor. And the whole loaf, which contains many slices, is a 3-dimensional tensor. 

## Defining Tensors, Constants and Variables

![](https://i.imgur.com/rABw57j.png)

Define 0-, 1-, 2-, and 3-dimensional tensors. Note that each object will be a tf dot Tensor object. 


![](https://i.imgur.com/FLIm8BE.png)

Constants are the simplest category of tensor in TensorFlow. A constant does not change and cannot be trained. It can, however, have any dimension.
Variable's value can change during computation. The value of a variable is shared, persistent, and modifiable. However, its data type and shape are fixed. 

# Exercices

## 1 - Constants

* Import the `constant` submodule from the `tensorflow` module.
* Convert the `credit_numpy` array into a `constant` object in `tensorflow`. Do not set the data type.


```python
    # Import constant from TensorFlow
    from tensorflow import constant

    # Convert the credit_numpy array into a tensorflow constant
    credit_constant = constant(credit_numpy)

    # Print constant datatype
    print('\n The datatype is:', credit_constant.dtype)

    # Print constant shape
    print('\n The shape is:', credit_constant.shape)
```
## 2 - Variables


* Define a variable, A1, as the 1-dimensional tensor: [1, 2, 3, 4].
* Apply .numpy() to A1 and assign it to B1.


```python
# Define the 1-dimensional variable A1
A1 = Variable([1, 2, 3, 4])

# Print the variable A1
print('\n A1: ', A1)

# Convert A1 to a numpy array and assign it to B1
B1 = A1.numpy()

# Print B1
print('\n B1: ', B1)
```
output:
```
<script.py> output:
    
     A1:  <tf.Variable 'Variable:0' shape=(4,) dtype=int32, numpy=array([1, 2, 3, 4], dtype=int32)>
    
     B1:  [1 2 3 4]
```

A [TF Tensor](https://www.tensorflow.org/api_docs/python/tf/Tensor) has different properties from a numpy array.

> Note that during eager execution, you may discover your `Tensors` are actually of type `EagerTensor`. This is an internal detail, but it does give you access to a useful function, `numpy`.

### A [guide on Tensors](https://www.tensorflow.org/guide/tensor)

# Basic Operations

```python
add.(TensorObject1, TensorObject2)
# Must have the same shape

multiply(TensorObject1, TensorObject2)
# Must have the same shape

matmul(TensorObject1, TensorObject2)

reduce_sum
```


<iframe
  src="https://colab.research.google.com/github/Portugapt/LearnHub-Public/blob/main/Embedded-tfTensors.ipynb"
></iframe>
