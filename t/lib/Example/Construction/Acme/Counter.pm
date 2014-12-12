package Example::Construction::Acme::Counter;

use strict;

our %__Meta = (
    has  => {
        count => { init_arg => 'start' },
    }, 
);

sub next {
    my ($self) = @_;

    $self->{$$}{count}++;
}

1;
