package Config::Pico;

use strict;
use warnings;
our $VERSION = '0.01';

use base 'Exporter';
use Carp ();
use File::Spec ();

our @EXPORT = qw(pico);

sub pico {
    my $base = $ENV{PICO_BASE} || "";
    $base = shift if (@_ > 1);
    my $file = shift;
    Carp::croak "'pico([\$base,] \$file)': too many arguments" if @_;
    $file = File::Spec->catfile($base, $file) if $base;
    Carp::croak "'$file': $!" unless -f $file;
    my @conf = do $file;
    if (@conf == 1 && ! defined $conf[0]) {
        Carp::croak "'$file': $@" if $@;
        Carp::croak "'$file': $!" if $!;
    }
    wantarray ? @conf : pop @conf;
}

1;
__END__

=head1 NAME

Config::Pico - Pure Perl Interpretative COnfiguration = do "config.pl"

=head1 SYNOPSIS

    use Config::Pico;
    
    # general use
    @config = pico($basedir, "config.pl");
    
    # user agent
    $ua = LWP::UserAgent->new(pico "ua.pl");
    
    # logger
    $logger = Log::Dispatch->new(pico "logger.pl");
    
    # memcache
    $memd = Cache::Memcached->new(pico "memd.pl");
    
    # database
    $dbh = DBI->connect(pico "dbh.pl");

=head1 DESCRIPTION

Use pure Perl to configure your app. This module exports C<pico()>
function which loads a configuration file written in Perl syntax.
You don't have to learn any other languages/notations like YAML,
XML, JSON, etc. to configure your Perl app as you already know Perl.

=head1 EXAMPLE CONFIGURATIONS

=head2 ua.pl for LWP::UserAgent

    +(
        agent        => "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
        max_redirect => 5,
        timeout      => 30,
        env_proxy    => 1,
    );

This literary returns an array which represents four of key/value
pair arguments to set up a new L<LWP::UserAgent> instance.
See L<LWP::UserAgent> for more options.

=head2 logger.pl for Log::Dispatch

    +(outputs => [
        ['File',   min_level => 'debug', filename => 'logfile'],
        ['Screen', min_level => 'warning'],
    ]);

Yes, any Perl syntaxs, including C<[]> arrayref etc., are available
as it's a Perl script.
See L<Log::Dispatch> for more options.

=head2 memd.pl for Cache::Memcached

    +{
        'servers' => [ "10.0.0.15:11211", "10.0.0.15:11212", "/var/sock/memcached",
                       "10.0.0.17:11211", [ "10.0.0.17:11211", 3 ] ],
        'debug' => 0,
        'compress_threshold' => 10_000,
    }

This represents a hashref.
See L<Cache::Memcached> for more options.

=head2 dbh.pl for DBD::SQLite

    +(
        "dbi:SQLite:dbname=dbfile", "", "", {
            AutoCommit        =>  1,
            RaiseError        =>  1,
            sqlite_unicode                   => 1,
            sqlite_allow_multiple_statements => 1,
        },
    );

See L<DBI> and L<DBD::SQLite> for more options.

=head2 dbh.pl for DBD::mysql

    local %_ = (
        driver    =>  'mysql',
        database  =>  'xxxx',
        host      =>  'localhost',
        port      =>  '3306',
        username  =>  'xxxxxx',
        password  =>  'xxxxxxxx',
        attr      =>  {
            AutoCommit        =>  1,
            RaiseError        =>  1,
	    mysql_enable_utf8 =>  1,
        },
    );
    
    +("dbi:$_{driver}:database=$_{database};host=$_{host};port=$_{port}", $_{username}, $_{password}, $_{attr});

Note that this uses a local variable which is easy for human to read.
The last line represents an array packed for L<DBI>.
See L<DBD::mysql> for more options.

=head1 FUNCTION

=head2 pico([$dir,] $file)

The first argument C<$dir> is optional and specifies a base path.
This would help you when you have variations in environments,
e.g. development/staging/production etc.
Put configuration files in a directory for each environments.

    my $conf = pico("config/$ENV{PLACK_ENV}", "dbi.pl");

The last argument C<$file> specifies a filename of configuration
file written in Perl to load.

    my $conf = pico $file;

In fact, this is equivalent to

    my $conf = do $file;

The only difference between those two above is that, in a case that
C<$file> is not exist, C<pico()> raises an error while C<do()> doesn't.
It'd be still easy for you to switch off the module and call C<do()>
instead of C<pico()>.

=head1 AUTHOR

Yusuke Kawasaki http://www.kawa.net/

=head1 COPYRIGHT

The following copyright notice applies to all the files provided in
this distribution, including binary files, unless explicitly noted
otherwise.

Copyright 2012 Yusuke Kawasaki

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Config::PP> - This provides C<config_set()> function which dump
a pure Perl file as well as C<config_get()> function to load it
like C<pico()> does.

=cut
