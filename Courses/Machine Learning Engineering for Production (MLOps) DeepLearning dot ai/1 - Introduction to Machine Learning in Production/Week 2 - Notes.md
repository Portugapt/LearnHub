# Questions


# Key challenges in creating an ML production ready model

## Keywords

- Model-centric AI development
- Data-centric AI development

## Key Challenges

Each time in the loop, know what to change.  
Either the Model, or the hyperparameters, or the data.  

![Cycle](https://i.imgur.com/sYnNIuG.png)

### Milestones

1. Do well on the training set
2. Do well on the dev/test sets
3. Do well in **business metrics/project goals**

We need something above a low average error on the test set. It isn't enough for a business. 

![Challenges](https://i.imgur.com/c59WYuf.png)

# Why low average error isn't good enough

![disproportion](https://i.imgur.com/JEmzcXM.png)

Some slices of the data are disproportionally more important, and in this case, Navigational queries users are more unforgiving if these queries don't yield out the results at the top.

![fairness](https://i.imgur.com/0gro2ip.png)

The same thing happens with slices of data might give imoral and unfair bias.

![rareclasses](https://i.imgur.com/0qXO6Oh.png)

And finally, rare classes (undersampled data), the test set might have an astronomical accuracy.

