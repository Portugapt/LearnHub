# Week 4

- [Week 4](#week-4)
  - [Error Control](#error-control)
    - [Parity check](#parity-check)
    - [Polynomial Codes](#polynomial-codes)
    - [Checksum](#checksum)
  - [Quiz 1: Practice Assessment - Error Control](#quiz-1-practice-assessment---error-control)
  - [Quiz 2: Graded Assessment - Error Control](#quiz-2-graded-assessment---error-control)
    - [Question 1: Given an information polynomial code $I(x) = X^7 + x^6 + x^1 + 1$, which is its corresponding per-bit information frame?](#question-1-given-an-information-polynomial-code-ix--x7--x6--x1--1-which-is-its-corresponding-per-bit-information-frame)
    - [Question 2: What is the remainder obtained by dividing x^7 + x^5 + 1 by the generator polynomial x^3 + 1?](#question-2-what-is-the-remainder-obtained-by-dividing-x7--x5--1-by-the-generator-polynomial-x3--1)
    - [Question 3: Given a	generator polynomial g(x) = x^3 + x + 1. Consider the information sequence 1001. By CRC method, what is the resulted codeword for transmission?](#question-3-given-agenerator-polynomial-gx--x3--x--1-consider-the-information-sequence-1001-by-crc-method-what-is-the-resulted-codeword-for-transmission)
    - [Question 4: Which of following generator polynomial can detect all single bit errors in an information frame?](#question-4-which-of-following-generator-polynomial-can-detect-all-single-bit-errors-in-an-information-frame)
    - [Question 5: Internet protocols use check bits to detect errors, instead of using CRC polynomial. The primary rationale is](#question-5-internet-protocols-use-check-bits-to-detect-errors-instead-of-using-crc-polynomial-the-primary-rationale-is)
    - [Question 6: The two basic approaches in error control are error prevention and detection, and error correction and re-transmission](#question-6-the-two-basic-approaches-in-error-control-are-error-prevention-and-detection-and-error-correction-and-re-transmission)
    - [Question 7: Find parity bit for 1001011](#question-7-find-parity-bit-for-1001011)
    - [Question 8: The divisor in a cyclic code is normally called the _________.](#question-8-the-divisor-in-a-cyclic-code-is-normally-called-the-_________)
    - [Question 9: The checksum of 0000 and 0000 is](#question-9-the-checksum-of-0000-and-0000-is)
    - [Question 10: In ASCII, a single parity bit code can detect ________ errors.](#question-10-in-ascii-a-single-parity-bit-code-can-detect-________-errors)

## Error Control

![errorcontrol1](https://i.imgur.com/8cqH7vg.png)

Codeword:  
n-bit codeword: a frame of m-bit data + k-bit redundant check bits (n = m+k)

![simpleconceptcontrol](https://i.imgur.com/JGs9hCR.png)

### Parity check

![paritycheck](https://i.imgur.com/mGcVTrV.png)

If there is one error bit, the error is detected.  
If there are two errors bits, the error is not detected.  


The parity check bit ensures that the total numbers of `1s` in the codeword is even, that is, the codeword has even parity.
The parity bit is calculated by modulo 2 arithmetic.  
Receiver checks to see if the number of 1s is even in its received codeword. One can tell that this coding scheme can have blind spots or error patterns that change an odd number of bits are detectable.
But all even numbered patterns are undetectable. 

![parity2](https://i.imgur.com/SvHtF7b.png)

![parity3](https://i.imgur.com/zD4P9Cc.png)

Double parity check

But is it possible to dictate more errors if we add more check bits? A simple method to improving error detection capability of a single parity check, is to arrange columns that consist of k information bits followed up by a check bit at the bottom of each column.
The right most bit in each row is the check bit of other bits in the row. So in fact as a last column is the parity column. The result encoded a matrix of bits satisfies the pattern that all rows have even parity and all columns have even parity. For one or two errors occur anywhere in the matrix of bit scale in transmission. And at least one row or one parity check will fail, an error is detected. If three errors occur anywhere in the matrix, at least one row or one parity check will fail and errors detected. But some virus are undetectable.

![parity4](https://i.imgur.com/IPgEBVz.png)

![parity5](https://i.imgur.com/hFjOJ5Z.png)

### Polynomial Codes

![summary](https://i.imgur.com/BZzrrdv.png)

![polcodes](https://i.imgur.com/gGSl74D.png)

![polcodes2](https://i.imgur.com/kBPIxbo.png)

![polcodes3](https://i.imgur.com/KCOBB8V.png)

![polcodes4](https://i.imgur.com/63ceG1I.png)

To understand the CRC idea, we assume we are dealing with a code in which the codeword has n bits of which k are information bits, and n- k are check bits. The procedure of error detection is as follows. The k bits information is used to calculate the check bits, according to a generator polynomial gx that a half degree of n- k.

![crc1](https://i.imgur.com/joIAhqT.png)

![crc2](https://i.imgur.com/aiFD0Y7.png)

Lets take it by example. This is very confusing....

![crcexample1](https://i.imgur.com/eLHy11i.png)

![crcexample2](https://i.imgur.com/tXj8NTN.png)

https://rndtool.info/amp/CRC-step-by-step-calculator/

![crcrecap](https://i.imgur.com/suoZFMx.png)

Design good polynomials codes

![polynomials](https://i.imgur.com/WffUEQc.png)

![polys2](https://i.imgur.com/GogqWP1.png)

### Checksum

![check1](https://i.imgur.com/KAazDn1.png)

![check2](https://i.imgur.com/I92oUpI.png)

he sum of the 16 bit of words and as a checksum modulo 2 power of 16 minus 1, the result must be zero. Otherwise, there is an error. We give an example. For simplicity, let's assume 4-bit words instead of 16- bit words.

![check3](https://i.imgur.com/m7oYdVs.png)

![check4](https://i.imgur.com/G9OUqSy.png)

## Quiz 1: Practice Assessment - Error Control

Q1

Given a 7-bit  information frame (0, 1, 0, 1, 1, 0, 1), what is the even parity bit?

- [ ] 1
- [X] 0
- [ ] None of the above

    -------

Q2

Which of following statements are true for single-bit parity error detection?

- [x] It can detect all single bit errors in an information frame
- [ ] It can detect all tripe bit errors in an information frame

    -------

Q3

Which of following statements are true for two-dimensional parity error detection?

- [ ] It can detect all single bit errors in an information frame <---
- [ ] It can correct all single bit errors in an information frame
- [ ] It can detect all double bit errors in an information frame
- [x] All of the above

    -------

Q4

Assume bit errors occur at random. If each bit has 50% probability to be in error by transmission. What is the probability of a four-bit frame to be in error by transmission?

- 1/16

    -------

Q5

What is the binary sequence that corresponds to polynomial code $X^3 + x^2 + 1$?

- 1101

    -------

Q6

Block codes are generated using _____.

- [x] Generator matrix
- [ ] Generator polynomial
- [ ] Both of the mentioned
- [ ] None of the mentioned

Block codes can be generated using generator matrix.

A cyclic code can be generated using Generator polynomial.
    -------

Q7

Which of the following is true for two-dimensional parity check

- [ ] Add multiple parity bits to each column
- [X] Arrange information in columns
- [X] More parity bit to improve coverage
- [ ] Arrange information in rows
    
    -------

Q8

Polynomial codes are implemented using shift register circuits

- True

    -------

Q9

What is the binary equivalent of the following polynomial arithmetic $x7 + x6 + x5 + x2 + 1$

- 11100101

    -------

Q10

Using Euclidean Division, what will be the remainder of 70 by 999 where 70 is the divisor and 999 is the dividend

- 19

## Quiz 2: Graded Assessment - Error Control

### Question 1: Given an information polynomial code $I(x) = X^7 + x^6 + x^1 + 1$, which is its corresponding per-bit information frame?

- 1100011

### Question 2: What is the remainder obtained by dividing x^7 + x^5 + 1 by the generator polynomial x^3 + 1?

- [ ] x^2 + x
- [ ] x^2 + 1
- [x] x^2 + x + 1
- [ ] None of the above

### Question 3: Given a	generator polynomial g(x) = x^3 + x + 1. Consider the information sequence 1001. By CRC method, what is the resulted codeword for transmission?

- 1001110

### Question 4: Which of following generator polynomial can detect all single bit errors in an information frame?

- [ ] $g(x) = x$
- [ ] $g(x) = x^2$
- [x] $g(x) = x + 1 $
- [ ] All of the above

### Question 5: Internet protocols use check bits to detect errors, instead of using CRC polynomial. The primary rationale is

- Simplicity of implementation

### Question 6: The two basic approaches in error control are error prevention and detection, and error correction and re-transmission

- False

### Question 7: Find parity bit for 1001011

https://www.toolmenow.com/32/Even-Parity-Calculator

- 0

### Question 8: The divisor in a cyclic code is normally called the _________.

- Generator

### Question 9: The checksum of 0000 and 0000 is

- 1111

### Question 10: In ASCII, a single parity bit code can detect ________ errors.

- An odd number of 