package Example::Construction::Counter_v2;

use strict;
use Minions ();

our %__Meta = (
    interface => [ qw( next ) ],

    construct_with => {
        start => {
            assert => {
                is_integer => sub { $_[0] =~ /^\d+$/ }
            },
        },
    },
    implementation => 'Example::Construction::Acme::Counter',
);

sub new {
    my ($class, $start) = @_;

    my $utility_class = Minions::utility_class($class);
    $utility_class->assert('start' => $start);
    my $obj = $utility_class->new_object;
    $obj->{$$}{count} = $start;
    return $obj;
}

Minions->minionize;
