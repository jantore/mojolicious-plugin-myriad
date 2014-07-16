#!/usr/bin/env perl

use strict;

use Myriad::Schema;
use Mojolicious::Lite;

use Test::More;
use Test::Mojo;

my $schema = Myriad::Schema->connect('dbi:SQLite:dbname=:memory:');
$schema->deploy();
$schema->populate_test();

my $t = Test::Mojo->new;

plugin 'Myriad' => {
    schema  => $schema,
    tracker => 'tracker.example.net'
};

$t->get_ok('/announce?info_hash=invalid')
    ->status_is(200)
    ->content_type_is('text/plain')
    ->content_like(qr{^d.*e$});

$t->get_ok('/scrape?info_hash=invalid')
    ->status_is(200)
    ->content_type_is('text/plain')
    ->content_like(qr{^d.*e$});

done_testing;
