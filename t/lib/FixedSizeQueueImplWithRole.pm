package FixedSizeQueueImplWithRole;

use strict;

our %__Meta = (
    roles => ['FixedSizeQueueRole'],
    has  => {
        max_size => { 
            init_arg => 'max_size',
            reader => 1,
        },
    }, 
);

1;
