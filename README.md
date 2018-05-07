# NAME

Mojolicious::Plugin::Myriad - Plug Myriad into your Mojolicious application

# SYNOPSIS

    use Mojolicious::Lite;

    plugin 'Myriad' => {
        db      => ['dbi:SQLite:dbfile=myriad.sql'],
        tracker => 'tracker.example.net'
    };

    get '/' => sub {
        # list torrents
    };

# DESCRIPTION

Mojolicious::Plugin::Myriad lets you easily plug [Myriad](https://metacpan.org/pod/Myriad) into a new or
existing [Mojolicious](https://metacpan.org/pod/Mojolicious) application. This can for instance be used to provide
torrent file downloads and tracker statistics from the same site as the
tracker is exposed on.

# AUTHOR

Jan Tore Morken <dist@jantore.net>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014-2018 by Jan Tore Morken.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
