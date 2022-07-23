import redis

r = redis.Redis(host='localhost', port=6379, db=0, health_check_interval=30)

r.set("banana", "Loel")
output1 = r.get("banana")

print(output1)

r.hmset('user:450', {'firstName': 'Jeremy','lastNmae':'Henry'})

# hincrby - increment by in the hash.

output2 = r.hgetall('user:450')

print(output2)

r.lpush('key', 'v1', 'v2')

r.sadd('groceries:dairies', 'milk', 'cheese', 'yogourt')
r.sadd('groceries:seafood', 'salmon', 'calamari', 'lobster')
r.sadd('groceries:fruits', 'apples', 'grapes', 'pears', 'orange')

print(r.smembers('groceries:fruits'))

# sentinel
# or cluster

