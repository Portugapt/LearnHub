docker run -it --name redisContainer -v `pwd`/local-data/:/data -p 6379:6379 redis/redis-stack-server:latest