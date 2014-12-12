use strict;
use Test::Lib;
use Test::Most;
use Minions ();

{
    package Alpha;

    our %__Meta = (
        role => 1,
        roles => [qw( Bravo Charlie )]
    );

    sub alpha { 'alpha' }
}

{
    package Bravo;

    our %__Meta = (
        role => 1,
        roles => [qw( Delta )]
    );

    sub bravo { 'bravo' }
}

{
    package Charlie;

    our %__Meta = (
        role => 1,
    );

    sub charlie { 'charlie' }
}

{
    package Delta;

    our %__Meta = (
        role => 1,
    );

    sub delta { 'delta' }
    sub charlie { 'charlieX' }
}

{
    package AlphabetImpl;

    our %__Meta = (
        roles => [qw( Alpha )],
    );
}

{
    package Alphabet;

    our %__Meta = (
        interface => [qw( alpha bravo charlie delta )],
        implementation => 'AlphabetImpl',
    );
    our $Error;

    eval { Minions->minionize }
      or $Error = $@;
}

package main;

like($Alphabet::Error, qr|Cannot have 'charlie' in both Charlie and Delta|);

done_testing();
