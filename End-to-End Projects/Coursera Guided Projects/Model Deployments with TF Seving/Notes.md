# Model deployments with TF Serving

https://github.com/snehankekre/Deploy-Deep-Learning-Models-TF-Serving-Docker

Most models don't get deployed.

A very inefficient way to deploy a model:  
![img1](https://i.imgur.com/nGPYGL2.png)

Forcing a lock on CPU. everyone else is expected to wait.  

![img2](https://i.imgur.com/RN4tm5C.png)

TF Hub is a good repository for transfer learning.

TF Serving understands when there's a new version of the model, and updates it automatically.  