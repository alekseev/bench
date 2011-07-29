import re

text = open('../../data/lorem.txt', 'r').read()

for i in range(100000):
	re.search('[a-zA-Z]', text)
