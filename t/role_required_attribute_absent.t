use strict;
use Test::Lib;
use Test::Most;
use Minions ();

{
    package Greeter;

    our %__Meta = (
        role => 1,
        requires => { attributes => ['name'] }
    );

    sub greet {
        my ($self) = @_;
        return "Hello $self->{$$}{name}";
    }
}

{
    package PersonImpl;

    our %__Meta = (
        roles => [qw( Greeter )],
    );
}

{
    package Person;

    our %__Meta = (
        interface => [qw( greet )],
        implementation => 'PersonImpl',
    );
}

package main;

throws_ok {
    Minions->minionize(\ %Person::__Meta);
} qr/Attribute 'name', required by role Greeter, is not defined./;

done_testing();
