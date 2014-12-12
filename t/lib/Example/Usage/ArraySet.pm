package Example::Usage::ArraySet;

use strict;

our %__Meta = (
    has => { set => { default => sub { [] } } },
);

sub has {
    my ($self, $e) = @_;
    scalar grep { $_ == $e } @{ $self->{$$}{set} };
}

sub add {
    my ($self, $e) = @_;

    if ( ! $self->has($e) ) {
        push @{ $self->{$$}{set} }, $e;
    }
}

1;
