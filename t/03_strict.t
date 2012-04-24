use strict;
use Test::More tests => 4;

BEGIN { use_ok 'Config::Pico' }

my @conf;

eval {
    @conf = do "t/config/usestrict.pl";
};

ok(! $@, "do() doesn't raise error");

eval {
    @conf = pico "t/config/usestrict.pl";
};

ok($@, "pico() raises error");

eval {
    @conf = pico "t/config/nostrict.pl";
};

ok(! $@, "pico() doesn't raise error without 'use strict'");
