Vale mais ter os notebooks em hyperlink.


- [What is a tensor?](#what-is-a-tensor)
  - [Defining Tensors, Constants and Variables](#defining-tensors-constants-and-variables)
- [Exercices](#exercices)
  - [1 - Constants](#1---constants)
  - [2 - Variables](#2---variables)
    - [A guide on Tensors](#a-guide-on-tensors)
- [Basic Operations](#basic-operations)
  - [Multiply Exercise](#multiply-exercise)
  - [Matrix Multiplication Exercise](#matrix-multiplication-exercise)
  - [Reduce Sum Exercise](#reduce-sum-exercise)
- [More advanced operations](#more-advanced-operations)
  - [Gradient](#gradient)
  - [Reshaping](#reshaping)


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


## Multiply Exercise

```python
# Define tensors A1 and A23 as constants
A1 = constant([1, 2, 3, 4])
A23 = constant([[1, 2, 3], [1, 6, 4]])

# Define B1 and B23 to have the correct shape
B1 = ones_like(1)
B23 = ones_like(A23)
# Perform element-wise multiplication
C1 = multiply(A1, B1)
C23 = multiply(A23, B23)

# Print the tensors C1 and C23
print('\n C1: {}'.format(C1.numpy()))
print('\n C23: {}'.format(C23.numpy()))
```

## Matrix Multiplication Exercise


* Define features, params, and bill as constants.
* Compute the predicted value vector, billpred, by multiplying the input data, features, by the parameters, params. Use matrix multiplication, rather than the element-wise product.
* Define error as the targets, bill, minus the predicted values, billpred.


```python
# Define features, params, and bill as constants
features = constant([[2, 24], [2, 26], [2, 57], [1, 37]])
params = constant([[1000], [150]])
bill = constant([[3913], [2682], [8617], [64400]])

# Compute billpred using features and params
billpred = matmul(features, params)
print(billpred)
# Compute and print the error
error = bill - billpred
print(error.numpy())
```

## Reduce Sum Exercise

https://www.tensorflow.org/api_docs/python/tf/math/reduce_sum

![](https://i.imgur.com/GfeuUjn.png)

```python
reduce_sum(wealth, 0).numpy()
## Out: array([ 50, 122], dtype=int32)
## 50k in BOnds, 122K in stocks.
```

# More advanced operations

![](https://i.imgur.com/ygfQ2ht.png)

![](https://i.imgur.com/xo6q0QD.png)

## Gradient

Find the derivative.
> Record operations for automatic differentiation.  

At [TF Gradients](https://www.tensorflow.org/api_docs/python/tf/GradientTape)

![](https://i.imgur.com/9cYcOty.png)


---

* Define x as a variable with the initial value x0.
* Set the loss function, y, equal to x multiplied by x. Do not make use of operator overloading.
* Set the function to return the gradient of y with respect to x.


```python
def compute_gradient(x0):
  	# Define x as a variable with an initial value of x0
	x = Variable(x0)
	with GradientTape() as tape:
		tape.watch(x)
        # Define y using the multiply operation
		y = x * x
    # Return the gradient of y with respect to x
	return tape.gradient(y, x).numpy()

# Compute and print gradients at x = -1, 1, and 0
print(compute_gradient(-1.0))
print(compute_gradient(1.0))
print(compute_gradient(0.0))
```


## Reshaping

Greyscale

![](https://i.imgur.com/TGYBiKf.png)

Color
![](https://i.imgur.com/wpSxjzs.png)


Reshaping a 2/3-rank tensor into a vector.

```python
# Reshape the grayscale image tensor into a vector
gray_vector = reshape(gray_tensor, (28*28, 1))

# Reshape the color image tensor into a vector
color_vector = reshape(color_tensor, (28*28*3, 1))
```

```python
# Reshape model from a 1x3 to a 3x1 tensor
model = reshape(model, (3*1, 1))

# Multiply letter by model
output = matmul(letter, model)

# Sum over output and print prediction using the numpy method
prediction = reduce_sum(output, 0)
print(prediction.numpy())
```