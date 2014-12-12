package FixedSizeQueueImpl;

use strict;

our %__Meta = (
    has  => {
        q => { default => sub { [ ] } },
        max_size => { 
            init_arg => 'max_size',
            reader => 1,
        },
    }, 
);

sub size {
    my ($self) = @_;
    scalar @{ $self->{$$}{q} };
}

sub push {
    my ($self, $val) = @_;

    push @{ $self->{$$}{q} }, $val;
}

1;
