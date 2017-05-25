#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use v5.16;
use feature 'say';
use feature 'switch';

say 'Enter number to be converted';
my $numba = <STDIN>;
#say 'Enter number of bits allocated for number';

print dec2bin($numba);
print "\nDone.\n";

#credit to vroom on perlmonks.org for providing info to help construct fxn:
#http://www.perlmonks.org/?node_id=2664
sub dec2bin {
    my $str = $_;
    $str = unpack("B32", pack("N", shift));

    return $str;
}
