open FILE, "<../../data/lorem.txt" or die $!;
$text = <FILE>;

for ($i = 0; $i < 1000; $i++) {
	split /\w/ => $text
}