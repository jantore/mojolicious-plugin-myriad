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

eval {
    plugin 'Myriad' => {
        schema   => $schema,
        tracker  => 'tracker.example.net',
    };
};

ok !$@, "load plugin";
isa_ok $t->app->routes->find('myriad-announce'), 'Mojolicious::Routes::Route';
isa_ok $t->app->routes->find('myriad-scrape'),   'Mojolicious::Routes::Route';

done_testing;
