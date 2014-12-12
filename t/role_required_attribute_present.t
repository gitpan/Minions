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
        return "Hello, I am $self->{$$}{name}";
    }
}

{
    package PersonImpl;
    our %__Meta = (
        roles => [qw( Greeter )],
        has => { name => { init_arg => 'name' } }
    );
}

{
    package Person;

    our %__Meta = (
        interface => [qw( greet )],
        construct_with => {
            name => { },
        },
        implementation => 'PersonImpl',
    );
    Minions->minionize;
}

package main;

my $person = Person->new(name => 'Bob');
is($person->greet, 'Hello, I am Bob', 'required attribute present');

done_testing();
