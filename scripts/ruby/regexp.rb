a = open('../../data/lorem.txt').read

1000.times do
  a.scan /\w/
end