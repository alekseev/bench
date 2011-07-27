import re

f = open('../../data/lorem.txt', 'r')
text = f.read()

for i in range(1000):
	re.search('[a-zA-Z]', text)