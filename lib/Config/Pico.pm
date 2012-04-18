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

;1;
__END__

1;
__END__

=encoding utf-8

=for stopwords

=head1 NAME

Config::Pico - Picoscale Perl Interpretative COnfiguration

=head1 SYNOPSIS

    use Config::Pico;
    
    # general use
    @config = pico($basedir, "config.pl");

    # user agent
    $ua = LWP::UserAgent->new(pico("lwp.pl"));

    # logger
    $logger = Log::Dispatch->new(pico("log.pl"));

    # database
    $dbh = DBI->connect(pico("dbi.pl"));

lwp.pl configuration for L<LWP::UserAgent>

    +(
        agent        => "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
        max_redirect => 5,
        timeout      => 30,
        env_proxy    => 1,
    ); 

log.pl configuration for L<Log::Dispatch>

    +(outputs => [
        ['File',   min_level => 'debug', filename => 'logfile'],
        ['Screen', min_level => 'warning'],
    ]);

dbi.pl configuration for L<DBI>, L<DBD::SQLite>

    +(
        "dbi:SQLite:dbname=dbfile", "", "", {
            sqlite_unicode                   => 1,
            sqlite_allow_multiple_statements => 1,
            sqlite_use_immediate_transaction => 1,
        },
    );

another configuration for L<DBD::MySQL>

    local %_ = (
        driver    =>  'mysql',
        database  =>  'xxxx',
        host      =>  'localhost',
        port      =>  '3306',
        username  =>  'xxxx',
        password  =>  'xxxxxxxx',
        attr      =>  {
            RaiseError        =>  1,
            AutoCommit        =>  1,
	    mysql_enable_utf8 =>  1,
        },
    );
    
    +("dbi:$_{driver}:database=$_{database};host=$_{host};port=$_{port}", $_{username}, $_{password}, $_{attr});

=head1 DESCRIPTION

TBD

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

=cut
