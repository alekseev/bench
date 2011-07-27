use Digest::MD5;

$ctx = Digest::MD5->new;

for ($i = 0; $i < 1000; $i++) {
	$ctx->add(rand(1000));
	$ctx->hexdigest;
}
