use strict;
use Test::More;
use Minions ();

my %Class = (
    interface => [qw(next)],
    class_methods => {
        new => sub {
            my ($class, $start) = @_;

            my $utility_class = Minions::utility_class($class);
            my $obj = $utility_class->new_object;
            $obj->{$$}{count} = $start;
            return $obj;
        },
    },
    implementation => {
        has  => {
            count => { default => 0 },
        }, 
        methods => {
            next => sub {
                my ($self) = @_;

                $self->{$$}{count}++;
            }
        },
    },
);

my $counter = Minions->minionize(\%Class)->new(1);

is($counter->next, 1);
is($counter->next, 2);
is($counter->next, 3);
done_testing();
