use ExtUtils::MakeMaker;

my $opt = {
    NAME                =>  'Config::Pico',
    VERSION_FROM        =>  'lib/Config/Pico.pm',
    CONFIGURE_REQUIRES  =>  {
        'ExtUtils::MakeMaker' =>  '6.55',
    },
    BUILD_REQUIRES      =>  {
        'Test::More'          =>  '0',
    },
    PREREQ_PM           =>  {
        # no dependencies
    },
    LICENSE             =>  'perl',
    ABSTRACT_FROM       =>  'lib/Config/Pico.pm',
    AUTHOR              =>  'Yusuke Kawasaki',
};

WriteMakefile( %$opt );
