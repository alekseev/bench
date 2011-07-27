a = open('../../data/lorem.txt').read

1000000.times do
  a.scan /\w/
end
