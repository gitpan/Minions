use strict;
use Test::Lib;
use Test::Most;
use Minions ();

{
    package SorterRole;

    our %__Meta = (
        role => 1,
        requires => { methods => ['cmp'] }
    );

    sub sort {
        my ($self, $items) = @_;
        my $cmp = sub { $self->cmp(@_) };
        return sort $cmp @$items;
    }
}

{
    package SorterImpl;

    our %__Meta = (
        roles => [qw( SorterRole )],
    );
}

{
    package Sorter;

    our %__Meta = (
        interface => [qw( sort )],
        implementation => 'SorterImpl',
    );
}

package main;

throws_ok {
    Minions->minionize(\ %Sorter::__Meta);
} qr/Method 'cmp', required by role SorterRole, is not implemented./;

done_testing();
