use strict;
use warnings;
use Test::More tests => 5;

BEGIN { use_ok 'Config::Pico' }

my $a = do "t/config/string.pl";
is($a, 'foobar', 'do');

my $b = pico "t/config/string.pl";
is($b, 'foobar', 'do');

my $c = pico "t/config" => "string.pl";
is($c, 'foobar', 'do');

my $d = pico("t/config", "string.pl");
is($d, 'foobar', 'do');
