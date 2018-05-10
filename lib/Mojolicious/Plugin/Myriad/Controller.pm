package Mojolicious::Plugin::Myriad::Controller;

use Mojo::Base 'Mojolicious::Controller';

use Bencode qw{ bencode };

sub track {
    my ($self) = @_;

    my $mode = $self->stash->{'myriad.mode'};
    my $tracker = $self->myriad;

    # Just in case.
    return if not $mode =~ /^(?:announce|scrape)$/;

    my $params = $self->req->params->to_hash;
    $params->{'ip'} ||= $self->tx->remote_address;

    $self->render(
        data => bencode($tracker->$mode(%{ $params }))
    );
}

sub render {
    my $self = shift;
    my %param = @_;

    $self->res->headers->content_type('text/plain');
    $self->res->body($param{'data'});
    $self->rendered(200);
}

1;
