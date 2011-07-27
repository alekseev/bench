require 'digest/md5'
1000000.times do
  Digest::MD5.hexdigest(Random.rand(1000000).to_s)
end
