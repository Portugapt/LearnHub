# Unit Testing for Data Science in Python

- [Unit Testing for Data Science in Python](#unit-testing-for-data-science-in-python)
  - [Life-cycle](#life-cycle)
  - [pytest](#pytest)
  - [Reading the test results](#reading-the-test-results)
  - [Why](#why)
  - [Integration](#integration)
  - [Message argument](#message-argument)
  - [Floats](#floats)
  - [Multiple Assertions](#multiple-assertions)
  - [With Statement](#with-statement)
  - [How to consider a function well tested?](#how-to-consider-a-function-well-tested)
    - [Bad Arguments](#bad-arguments)
    - [Special Arguments](#special-arguments)
    - [Normal Arguments](#normal-arguments)
    - [Examples](#examples)
  - [Test-Driven deployment](#test-driven-deployment)
  - [Organize test units](#organize-test-units)
  - [Mastering organization](#mastering-organization)
  - [Expect to fail](#expect-to-fail)
  - [Continuous Integration](#continuous-integration)
  - [Setup and Teardown](#setup-and-teardown)
  - [Mocking](#mocking)
  - [Putting it all together](#putting-it-all-together)
    - [Non deterministic data-model](#non-deterministic-data-model)

## Life-cycle

![lyfe](https://i.imgur.com/aJsvr8d.png)

![lyfe2](https://i.imgur.com/8ch5m5T.png)

## pytest

![pytest](https://i.imgur.com/ouGRT0O.png)

![testmodule](https://i.imgur.com/hB3FVZs.png)

![testmodule2](https://i.imgur.com/iaR2M4H.png)

![testmodule3](https://i.imgur.com/Bg6Pr8U.png)

![testmodule4](https://i.imgur.com/jlLuUyY.png)

![testmodule5](https://i.imgur.com/nAhl1Gf.png)

![testmodule6](https://i.imgur.com/JHdQMG2.png)

```python
# Import the pytest package
import pytest

# Import the function convert_to_int()
from preprocessing_helpers import convert_to_int

# Complete the unit test name by adding a prefix
def test_on_string_with_one_comma():
  # Complete the assert statement
  assert convert_to_int("2,081") == 2081
```

## Reading the test results

![rtr1](https://i.imgur.com/FyIJWja.png)

![rtr2](https://i.imgur.com/CXPjmCN.png)

![rtr3](https://i.imgur.com/MYpXCsM.png)

![rtr4](https://i.imgur.com/rqsp1Zs.png)

## Why

![why1](https://i.imgur.com/i8K2H9U.png)

Benefits of unit testing

You have been invited to a meeting where company executives are discussing whether developers should write unit tests. The CEO is unsure, and asks you about the benefits that unit testing might bring. In your response, which of the following benefits should you include?

1. Time savings, leading to faster development of new features.
2. Improved documentation, which will help new colleagues understand the code base better.
3. More user trust in the software product.
4. Better user experience due to reduced downtime.


## Integration

![ci1](https://i.imgur.com/bRPyh2C.png)

We will focus on unit testing in this course.

## Message argument

![msg1](https://i.imgur.com/ieipfzu.png)

![msg2](https://i.imgur.com/eEwJ9ZC.png)

```python
def test_on_six_rows():
    example_argument = np.array([[2081.0, 314942.0], [1059.0, 186606.0],
                                 [1148.0, 206186.0], [1506.0, 248419.0],
                                 [1210.0, 214114.0], [1697.0, 277794.0]]
                                )
    # Fill in with training array's expected number of rows
    expected_training_array_num_rows = 4
    # Fill in with testing array's expected number of rows
    expected_testing_array_num_rows = 2
    actual = split_into_training_and_testing_sets(example_argument)
    # Write the assert statement checking training array's number of rows
    assert actual[0].shape[0] == expected_training_array_num_rows, "The actual number of rows in the training array is not {}".format(expected_training_array_num_rows)
    # Write the assert statement checking testing array's number of rows
    assert actual[1].shape[0] == expected_testing_array_num_rows, "The actual number of rows in the testing array is not {}".format(expected_testing_array_num_rows)
```

## Floats

![floats1](https://i.imgur.com/5n79kHP.png)

```python
import numpy as np
import pytest
from as_numpy import get_data_as_numpy_array

def test_on_clean_file():
  expected = np.array([[2081.0, 314942.0],
                       [1059.0, 186606.0],
  					   [1148.0, 206186.0]
                       ]
                      )
  actual = get_data_as_numpy_array("example_clean_data.txt", num_columns=2)
  message = "Expected return value: {0}, Actual return value: {1}".format(expected, actual)
  # Complete the assert statement
  assert actual == pytest.approx(expected), message
```

## Multiple Assertions

![assertdouble](https://i.imgur.com/FFueSRj.png)

## With Statement

![with1](https://i.imgur.com/q2wydKC.png)

![with2](https://i.imgur.com/ip5YODZ.png)

![with3](https://i.imgur.com/yRuUC5K.png)

![with4](https://i.imgur.com/DdxLCjo.png)

Sometimes, you want a function to raise an exception when called on bad arguments. This prevents the function from returning nonsense results or hard-to-interpret exceptions. This is an important behavior which should be unit tested.

```python
import pytest

try:
    # Fill in with a context manager that raises Failed if no OSError is raised
    with pytest.raises(OSError):
        raise ValueError
except:
    print("pytest raised an exception because no OSError was raised in the context.")
```

```python
import pytest

with pytest.raises(ValueError) as exc_info:
    raise ValueError("Silence me!")
# Check if the raised ValueError contains the correct message
assert exc_info.match("Silence me!")
```

```python
import numpy as np
import pytest
from train import split_into_training_and_testing_sets

def test_on_one_row():
    test_argument = np.array([[1382.0, 390167.0]])
    # Store information about raised ValueError in exc_info
    with pytest.raises(ValueError) as exc_info:
      split_into_training_and_testing_sets(test_argument)
    expected_error_msg = "Argument data_array must have at least 2 rows, it actually has just 1"
    # Check if the raised ValueError contains the correct message
    assert exc_info.match("Argument data_array must have at least 2 rows, it actually has just 1")
```

## How to consider a function well tested?

![goodtest](https://i.imgur.com/K4KvGZb.png)

![good2](https://i.imgur.com/hP8tu2O.png)

![good3](https://i.imgur.com/kMMyjYC.png)

### Bad Arguments

![bad1](https://i.imgur.com/apFQIB8.png)

![bad2](https://i.imgur.com/Q2AXlbk.png)

### Special Arguments

![special1](https://i.imgur.com/04DBRJo.png)

### Normal Arguments

![normal1](https://i.imgur.com/lE4hGIN.png)

### Examples

 The boundary values of row_to_list() are now marked in orange. The normal argument is marked in green and the values triggering special behavior are marked in blue. 

![ex1](https://i.imgur.com/oRiuhPW.png)

```python
## Boundary values

import pytest
from preprocessing_helpers import row_to_list

def test_on_no_tab_no_missing_value():    # (0, 0) boundary value
    # Assign actual to the return value for the argument "123\n"
    actual = row_to_list("123\n")
    assert actual is None, "Expected: None, Actual: {0}".format(actual)
    
def test_on_two_tabs_no_missing_value():    # (2, 0) boundary value
    actual = row_to_list("123\t4,567\t89\n")
    # Complete the assert statement
    assert actual is None, "Expected: None, Actual: {0}".format(actual)
    
def test_on_one_tab_with_missing_value():    # (1, 1) boundary value
    actual = row_to_list("\t4,567\n")
    # Format the failure message
    assert actual is None, "Expected: None, Actual: {0}".format(actual)


## Special Cases

def test_on_no_tab_with_missing_value():    # (0, 1) case
    # Assign to the actual return value for the argument "\n"
    actual = row_to_list('\n')
    # Write the assert statement with a failure message
    assert actual is None, "Expected: None, Actual: {0}".format(actual)
    
def test_on_two_tabs_with_missing_value():    # (2, 1) case
    # Assign to the actual return value for the argument "123\t\t89\n"
    actual = row_to_list("123\t\t89\n")
    # Write the assert statement with a failure message
    assert actual is None, "Expected: None, Actual: {0}".format(actual)

## Normal cases

def test_on_no_tab_with_missing_value():    # (0, 1) case
    # Assign to the actual return value for the argument "\n"
    actual = row_to_list('\n')
    # Write the assert statement with a failure message
    assert actual is None, "Expected: None, Actual: {0}".format(actual)
    
def test_on_two_tabs_with_missing_value():    # (2, 1) case
    # Assign to the actual return value for the argument "123\t\t89\n"
    actual = row_to_list("123\t\t89\n")
    # Write the assert statement with a failure message
    assert actual is None, "Expected: None, Actual: {0}".format(actual)
```

## Test-Driven deployment

![tdd1](https://i.imgur.com/2KvKIke.png)

![tdd2](https://i.imgur.com/ASpFTex.png)

## Organize test units

![orgunits](https://i.imgur.com/HvPECUX.png)

![orgunits2](https://i.imgur.com/YsjlZT9.png)

```python
import pytest
import numpy as np

from models.train import split_into_training_and_testing_sets

# Declare the test class
class TestSplitIntoTrainingAndTestingSets(object):
    # Fill in with the correct mandatory argument
    def test_on_one_row(self):
        test_argument = np.array([[1382.0, 390167.0]])
        with pytest.raises(ValueError) as exc_info:
            split_into_training_and_testing_sets(test_argument)
        expected_error_msg = "Argument data_array must have at least 2 rows, it actually has just 1"
        assert exc_info.match(expected_error_msg)
```

## Mastering organization

![rall](https://i.imgur.com/z80R2fi.png)

![ttm](https://i.imgur.com/cdfFs1r.png)

![ttm2](https://i.imgur.com/QDlRoQD.png)

![ttm3](https://i.imgur.com/fpnNzkU.png)

![ttm4](https://i.imgur.com/CzNhvW7.png)

![ttm5](https://i.imgur.com/pZUKYVg.png)

## Expect to fail

![ef1](https://i.imgur.com/Pzvelf1.png)

![ef2](https://i.imgur.com/p0O7BoN.png)

![ef3](https://i.imgur.com/uwc7jrT.png)

```python
# Add a reason for the expected failure
@pytest.mark.xfail(reason="Using TDD, model_test() has not yet been implemented")
class TestModelTest(object):
    def test_on_linear_data(self):
        test_input = np.array([[1.0, 3.0], [2.0, 5.0], [3.0, 7.0]])
        expected = 1.0
        actual = model_test(test_input, 2.0, 1.0)
        message = "model_test({0}) should return {1}, but it actually returned {2}".format(test_input, expected, actual)
        assert actual == pytest.approx(expected), message
        
    def test_on_one_dimensional_array(self):
        test_input = np.array([1.0, 2.0, 3.0, 4.0])
        with pytest.raises(ValueError) as exc_info:
            model_test(test_input, 1.0, 1.0)
```

## Continuous Integration

![ci1](https://i.imgur.com/iuNI8SK.png)

![ci2](https://i.imgur.com/7v3nkyi.png)

add to repo. Install Travis CI in repo

##  Setup and Teardown

![teardown1](https://i.imgur.com/EYgUeNx.png)

![fixture](https://i.imgur.com/fLSGetR.png)

![both1](https://i.imgur.com/wZJHZi1.png)

![both2](https://i.imgur.com/MQjrgzk.png)

https://docs.pytest.org/en/6.2.x/fixture.html

```python
# Add a decorator to make this function a fixture
@pytest.fixture
def clean_data_file():
    file_path = "clean_data_file.txt"
    with open(file_path, "w") as f:
        f.write("201\t305671\n7892\t298140\n501\t738293\n")
    yield file_path
    os.remove(file_path)
    
# Pass the correct argument so that the test can use the fixture
def test_on_clean_file(clean_data_file):
    expected = np.array([[201.0, 305671.0], [7892.0, 298140.0], [501.0, 738293.0]])
    # Pass the clean data file path yielded by the fixture as the first argument
    actual = get_data_as_numpy_array(clean_data_file, 2)
    assert actual == pytest.approx(expected), "Expected: {0}, Actual: {1}".format(expected, actual)   
```


When a function takes a data file as an argument, you need to write a fixture that takes care of creating and deleting that data file. This exercise will test your ability to write such a fixture. 

```python
@pytest.fixture
def empty_file():
    # Assign the file path "empty.txt" to the variable
    file_path = 'empty.txt'
    open(file_path, "w").close()
    # Yield the variable file_path
    yield file_path
    # Remove the file in the teardown
    os.remove(file_path)
    
def test_on_empty_file(self, empty_file):
    expected = np.empty((0, 2))
    actual = get_data_as_numpy_array(empty_file, 2)
    assert actual == pytest.approx(expected), "Expected: {0}, Actual: {1}".format(expected, actual)
```

```python
import pytest

@pytest.fixture
# Add the correct argument so that this fixture can chain with the tmpdir fixture
def empty_file(tmpdir):
    # Use the appropriate method to create an empty file in the temporary directory
    file_path = tmpdir.join("empty.txt")
    open(file_path, "w").close()
    yield file_path
```

## Mocking

![mock1](https://i.imgur.com/pjFBjB1.png)

![mock2](https://i.imgur.com/PNxAVaV.png)

![mock3](https://i.imgur.com/lVN7bzg.png)

![mock4](https://i.imgur.com/KFOR2dV.png)

![mock5](https://i.imgur.com/g8hpnbr.png)

![mock6](https://i.imgur.com/yaJvhtj.png)

![mock7](https://i.imgur.com/JnbNQJa.png)

![mock8](https://i.imgur.com/L24s1y9.png)

![mock9](https://i.imgur.com/77WgxnT.png)

```python
# Define a function convert_to_int_bug_free
def convert_to_int_bug_free(comma_separated_integer_string):
    # Assign to the dictionary holding the correct return values 
    return_values = {"1,801": 1801, 
                    "201,411": 201411, 
                    "2,002": 2002, 
                    "333,209": 333209, 
                    "1990": None, 
                    "782,911": 782911, 
                    "1,285": 1285, 
                    "389129": None}
    # Return the correct result using the dictionary return_values
    return return_values[comma_separated_integer_string]
```

```python
# Add the correct argument to use the mocking fixture in this test
def test_on_raw_data(self, raw_and_clean_data_file, mocker):
    raw_path, clean_path = raw_and_clean_data_file
    # Replace the dependency with the bug-free mock
    convert_to_int_mock = mocker.patch("data.preprocessing_helpers.convert_to_int",
                                       side_effect=convert_to_int_bug_free)
    preprocess(raw_path, clean_path)
    # Check if preprocess() called the dependency correctly
    assert convert_to_int_mock.call_args_list == [call("1,801"), call("201,411"), 
                            call("2,002"), call("333,209"), call("1990"), 
                            call("782,911"), call("1,285"), call("389129")]
    with open(clean_path, "r") as f:
        lines = f.readlines()
    first_line = lines[0]
    assert first_line == "1801\\t201411\\n"
    second_line = lines[1]
    assert second_line == "2002\\t333209\\n" 
```

## Putting it all together

![pt1](https://i.imgur.com/RS6vHK6.png)

![pt2](https://i.imgur.com/QEenG6o.png)

![pt3](https://i.imgur.com/qErXnLb.png)

### Non deterministic data-model

![ndm](https://i.imgur.com/KIFM2Vl.png)

![ndm2](https://i.imgur.com/YjYw6Yt.png)

```python
import numpy as np
import pytest
from models.train import model_test

def test_on_perfect_fit():
    # Assign to a NumPy array containing a linear testing set
    test_argument = np.array([[1.0, 3.0], [2.0, 5.0], [3.0, 7.0]])
    # Fill in with the expected value of r^2 in the case of perfect fit
    expected = 1.0
    # Fill in with the slope and intercept of the model
    actual = model_test(test_argument, slope=2.0, intercept=1.0)
    # Complete the assert statement
    assert actual == pytest.approx(expected), "Expected: {0}, Actual: {1}".format(expected, actual)
```

```python
def test_on_circular_data(self):
    theta = pi/4.0
    # Assign to a NumPy array holding the circular testing data
    test_argument = np.array([[1.0, 0.0], [cos(theta), sin(theta)],
                              [0.0, 1.0],
                              [cos(3 * theta), sin(3 * theta)],
                              [-1.0, 0.0],
                              [cos(5 * theta), sin(5 * theta)],
                              [0.0, -1.0],
                              [cos(7 * theta), sin(7 * theta)]]
                             )
    # Fill in with the slope and intercept of the straight line
    actual = model_test(test_argument, slope=0.0, intercept=0.0)
    # Complete the assert statement
    assert actual == pytest.approx(0)
```

pytest --mpl-generate-path /home/repl/workspace/project/tests/visualization/baseline -k "test_plot_for_almost_linear_data"