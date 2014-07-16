package Mojolicious::Plugin::Myriad;

use base 'Mojolicious::Plugin';
use version; our $VERSION = version->declare("v0.0.1");

sub register {
    my ($self, $app) = @_;
    my $controller = __PACKAGE__ . '::Controller';

    my $config = $_[2] || {};
    $config{'announce'} ||= '/announce';
    $config{'scrape'}     = 1 if not defined $config{'scrape'};

    $app->routes->route($config{'announce'})->via('GET')->to(
        namespace => $controller,
        action    => 'announce',
    );

    return if not $config{'scrape'};

    # Generate scrape path according to convention.
    my $scrape = $config{'announce'};
    return if not $scrape =~ s{/announce(?=[^/]*$)}{/scrape};

    $app->routes->route($scrape)->via('GET')->to(
        namespace => $controller,
        action    => 'scrape',
    );
}
  
1;
__END__

=head1 NAME

Mojolicious::Plugin::Myriad - Plug Myriad into your Mojolicious application

=head1 SYNOPSIS

  use Mojolicious::Lite;

  plugin 'Myriad' => { announce => '/announce' };
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

This software is copyright (c) 2014 by Jan Tore Morken.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.