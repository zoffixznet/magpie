package Magpie::Pipeline::Moe;
use Moose;
extends 'Magpie::Transformer';

__PACKAGE__->register_events(
    'foo',
     bar => sub {
        my ($self, $ctxt) = @_;
        my $body = $self->response->body || '';
        $body .= '_moebar_';
        $self->response->body( $body );
        return 100
     },
    'baz'
);

sub load_queue {
    return qw( baz bar );
}

sub foo {
    my ($self, $ctxt) = @_;
    my $body = $self->response->body || '';
    $body .= '_moefoo_';
    $self->response->body( $body );
    return 100;
}

sub baz {
    my ($self, $ctxt) = @_;
    my $body = $self->response->body || '';
    $body .= '_moebaz_';
    $self->response->body( $body );
    return 100;
}

1;