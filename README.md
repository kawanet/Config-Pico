# NAME

Config::Pico - Pure Perl Interpretative COnfiguration = do "config.pl"

# SYNOPSIS

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

# DESCRIPTION

Use pure Perl to configure your app. This module exports `pico()`
function which loads a configuration file written in Perl syntax.
You don't have to learn any other languages/notations like YAML,
XML, JSON, etc. to configure your Perl app as you already know Perl.

# EXAMPLE CONFIGURATIONS

## ua.pl for LWP::UserAgent

    +(
        agent        => "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
        max_redirect => 5,
        timeout      => 30,
        env_proxy    => 1,
    );

This literary returns an array which represents four of key/value
pair arguments to set up a new [LWP::UserAgent](http://search.cpan.org/perldoc?LWP::UserAgent) instance.
See [LWP::UserAgent](http://search.cpan.org/perldoc?LWP::UserAgent) for more options.

## logger.pl for Log::Dispatch

    +(outputs => [
        ['File',   min_level => 'debug', filename => 'logfile'],
        ['Screen', min_level => 'warning'],
    ]);

Yes, any Perl syntaxs, including `[]` arrayref etc., are available
as it's a Perl script.
See [Log::Dispatch](http://search.cpan.org/perldoc?Log::Dispatch) for more options.

## memd.pl for Cache::Memcached

    +{
        'servers' => [ "10.0.0.15:11211", "10.0.0.15:11212", "/var/sock/memcached",
                       "10.0.0.17:11211", [ "10.0.0.17:11211", 3 ] ],
        'debug' => 0,
        'compress_threshold' => 10_000,
    }

This represents a hashref.
See [Cache::Memcached](http://search.cpan.org/perldoc?Cache::Memcached) for more options.

## dbh.pl for DBD::SQLite

    +(
        "dbi:SQLite:dbname=dbfile", "", "", {
            AutoCommit        =>  1,
            RaiseError        =>  1,
            sqlite_unicode                   => 1,
            sqlite_allow_multiple_statements => 1,
        },
    );

See [DBI](http://search.cpan.org/perldoc?DBI) and [DBD::SQLite](http://search.cpan.org/perldoc?DBD::SQLite) for more options.

## dbh.pl for DBD::mysql

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
The last line represents an array packed for [DBI](http://search.cpan.org/perldoc?DBI).
See [DBD::mysql](http://search.cpan.org/perldoc?DBD::mysql) for more options.

# FUNCTION

## pico(\[$dir,\] $file)

The first argument `$dir` is optional and specifies a base path.
This would help you when you have variations in environments,
e.g. development/staging/production etc.
Put configuration files in a directory for each environments.

    my $conf = pico("config/$ENV{PLACK_ENV}", "dbi.pl");

The last argument `$file` specifies a filename of configuration
file written in Perl to load.

    my $conf = pico $file;

In fact, this is equivalent to

    my $conf = do $file;

The only difference between those two above is that, in a case that
`$file` is not exist, `pico()` raises an error while `do()` doesn't.
It'd be still easy for you to switch off the module and call `do()`
instead of `pico()`.

# AUTHOR

Yusuke Kawasaki http://www.kawa.net/

# COPYRIGHT

The following copyright notice applies to all the files provided in
this distribution, including binary files, unless explicitly noted
otherwise.

Copyright 2012 Yusuke Kawasaki

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Config::PP](http://search.cpan.org/perldoc?Config::PP) - This provides `config_set()` function which dump
a pure Perl file as well as `config_get()` function to load it
like `pico()` does.