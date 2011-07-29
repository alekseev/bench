a = open('../../data/lorem.txt').read

100000.times do
  a.scan /\w/
end
