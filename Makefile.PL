use ExtUtils::MakeMaker;

my $opt = {
    NAME                =>  'Config::Pico',
    VERSION_FROM        =>  'lib/Config/Pico.pm',
    PREREQ_PM           =>  {
        'Test::More'    =>  '0',
    },
    LICENSE             =>  'perl',
};

WriteMakefile( %$opt );
