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
        
        my $cmp = $self->{'!'}->can('cmp');
        return [ sort $cmp @$items ];
    }
}

{
    package SorterImpl;

    our %__Meta = (
        semiprivate => ['cmp'],
        roles => [qw( SorterRole )],
    );

    sub cmp ($$) {
        my ($x, $y) = @_;
        $y <=> $x;    
    }
}

{
    package Sorter;

    our %__Meta = (
        interface => [qw( sort )],
        implementation => 'SorterImpl',
    );
    Minions->minionize;
}

package main;

my $sorter = Sorter->new;

is_deeply($sorter->sort([1 .. 4]), [4,3,2,1], 'required method present.');
ok(! $sorter->can('cmp'), "Can't call private sub");

done_testing();
