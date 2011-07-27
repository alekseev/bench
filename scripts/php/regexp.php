<?php

$a = file_get_contents('data/lorem.txt');

for ($i = 0; $i < 1000000; $i++) {
	preg_match_all('/\w/', $a, $m);
}
