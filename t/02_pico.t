use strict;
use warnings;
use Test::More tests => 19;

BEGIN { use_ok 'Config::Pico' }

my $dir = 't/config';

my $string = pico($dir, "string.pl");
is($string, 'foobar', 'string');

my $one = pico($dir, "one.pl");
is($one, '1', 'one');

my $two = pico($dir, "two.pl");
is($two, '2', 'two');

my $zero = pico($dir, "zero.pl");
is($zero, '0', 'zero');

my $undef = pico($dir, "undef.pl");
ok(! defined $undef, 'undef');

my @array = pico($dir, "array.pl");
is($array[0], 'foo', 'array-0');
is($array[1], 'bar', 'array-1');

my @plusarray = pico($dir, "plusarray.pl");
is($plusarray[0], 'foo', 'plusarray-0');
is($plusarray[1], 'bar', 'plusarray-1');

my $arrayref = pico($dir, "arrayref.pl");
ok(ref $arrayref, 'arrayref');
is($arrayref->[0], 'foo', 'arrayref-0');
is($arrayref->[1], 'bar', 'arrayref-1');

my $plusarrayref = pico($dir, "plusarrayref.pl");
is($plusarrayref->[0], 'foo', 'plusarrayref-0');
is($plusarrayref->[1], 'bar', 'plusarrayref-1');

my $hashref = pico($dir, "hashref.pl");
ok(ref $hashref, 'hashref');
is($hashref->{foo}, 'bar', 'hashref-foo');

my $plushashref = pico($dir, "plushashref.pl");
ok(ref $plushashref, 'plushashref');
is($plushashref->{foo}, 'bar', 'plushashref-foo');
