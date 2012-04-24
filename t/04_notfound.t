use strict;
use Test::More tests => 3;

BEGIN { use_ok 'Config::Pico' }

my @conf;

eval {
    @conf = do "config/notfound.pl";
};

ok(! $@, "do() doesn't raise error");

eval {
    @conf = pico "config/notfound.pl";
};

ok($@, "pico() raises error");
