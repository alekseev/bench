import random
import hashlib

for i in range(1000):
	hashlib.md5(str(random.randint(1, 1000))).hexdigest()
