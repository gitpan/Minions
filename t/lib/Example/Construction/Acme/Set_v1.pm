package Example::Construction::Acme::Set_v1;

use strict;

our %__Meta = (
    has => { 
        set => { 
            default => sub { {} },
            init_arg => 'items',
            map_init_arg => sub { return { map { $_ => 1 } @{ $_[0] } } },
        } 
    },
);

sub has {
    my ($self, $e) = @_;
    exists $self->{$$}{set}{$e};
}

sub add {
    my ($self, $e) = @_;
    ++$self->{$$}{set}{$e};
}

1;
