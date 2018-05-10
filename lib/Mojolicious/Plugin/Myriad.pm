package Mojolicious::Plugin::Myriad;

use Mojo::Base 'Mojolicious::Plugin';
use version; our $VERSION = version->declare("v0.0.2");

use Myriad::Schema;

sub register {
    my ($self, $app) = @_;
    my $controller = __PACKAGE__ . '::Controller';

    my $config = { %{$_[2]} };

    $config->{'announce'} ||= '/announce';
    $config->{'scrape'}     = 1 if not defined $config->{'scrape'};

    if(not $config->{'schema'} and not $config->{'db'}) {
        die "Myriad: database not set";
    }

    my $m = $config->{'schema'} || Myriad::Schema->connect(
        @{ $config->{'db'} }
    ) or die "Myriad: could not connect to database";

    die "Myriad: tracker not set" if not $config->{'tracker'};
    my $tracker = $m->resultset('Tracker')->active->find($config->{'tracker'})
        or die sprintf("Myriad: tracker not found: %s", $config->{'tracker'});

    $app->helper(myriad => sub { return $tracker });

    $app->routes->route($config->{'announce'})->via('GET')->to(
        'namespace'      => $controller,
        'action'         => 'track',
        'myriad.mode'    => 'announce',
        'myriad.tracker' => $tracker,
    )->name('myriad-announce');

    # Returns if scraping is not allowed.
    return if not $config->{'scrape'};

    # Generate scrape path according to convention.
    my $scrape = $config->{'announce'};
    return if not $scrape =~ s{/announce(?=[^/]*$)}{/scrape};

    $app->routes->route($scrape)->via('GET')->to(
        'namespace'      => $controller,
        'action'         => 'track',
        'myriad.mode'    => 'scrape',
        'myriad.tracker' => $tracker,
    )->name('myriad-scrape');
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Myriad - Plug Myriad into your Mojolicious application

=head1 SYNOPSIS

  use Mojolicious::Lite;

  plugin 'Myriad' => {
      db      => ['dbi:SQLite:dbfile=myriad.sql'],
      tracker => 'tracker.example.net'
  };

  get '/' => sub {
      # list torrents
  };

=head1 DESCRIPTION

Mojolicious::Plugin::Myriad lets you easily plug L<Myriad> into a new or
existing L<Mojolicious> application. This can for instance be used to provide
torrent file downloads and tracker statistics from the same site as the
tracker is exposed on.

=head1 AUTHOR

Jan Tore Morken <dist@jantore.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014-2018 by Jan Tore Morken.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
