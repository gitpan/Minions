use strict;
use Test::Lib;
use Test::Most;
use Minions ();

{
    package Camper;

    our %__Meta = (
        role => 1,
    );

    sub pitch {
        my ($self) = @_;
    }
}

{
    package BaseballPro;

    our %__Meta = (
        role => 1,
    );

    sub pitch {
        my ($self) = @_;
    }
}

{
    package BusyDudeImpl;

    our %__Meta = (
        roles => [qw( Camper BaseballPro )],
    );
}

{
    package BusyDude;

    our %__Meta = (
        interface => [qw( pitch )],
        implementation => 'BusyDudeImpl'
    );
}
package main;

throws_ok {
    Minions->minionize(\ %BusyDude::__Meta);
} qr/Cannot have 'pitch' in both BaseballPro and Camper/;

done_testing();
