use strict;
use warnings;
use utf8;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::Myriad',
  VERSION_FROM => 'lib/Mojolicious/Plugin/Myriad.pm',
  ABSTRACT     => 'Plug Myriad into your Mojolicious application',
  AUTHOR       => 'Jan Tore Morken <dist@jantore.net>',
  LICENSE      => 'artistic_2',
  PREREQ_PM => {
    'Bencode'     => 0,
    'Mojolicious' => 0,
  },
  TEST_REQUIRES => {
    'Test::More' => 0,
  },
  test => {TESTS => 't/*.t'}
);
