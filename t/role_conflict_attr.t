use strict;
use Test::Lib;
use Test::Most;
use Minions ();

{
    package Lawyer;

    our %__Meta = (
        role => 1,
        has  => { clients => { default => sub { [] } } } 
    );
}

{
    package Server;

    our %__Meta = (
        role => 1,
        has  => { clients => { default => sub { [] } } } 
    );

    sub serve {
        my ($self) = @_;
    }
}

{
    package BusyDudeImpl;

    our %__Meta = (
        roles => [qw( Lawyer Server )],
    );
}

{
    package BusyDude;

    our %__Meta = (
        interface => [qw( serve )],
        implementation => 'BusyDudeImpl'
    );
}
package main;

throws_ok {
    Minions->minionize(\ %BusyDude::__Meta);
} qr/Cannot have 'clients' in both Server and Lawyer/;

done_testing();
