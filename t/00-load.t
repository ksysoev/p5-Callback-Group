#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Callback::Group' ) || print "Bail out!\n";
}

diag( "Testing Callback::Group $Callback::Group::VERSION, Perl $], $^X" );
