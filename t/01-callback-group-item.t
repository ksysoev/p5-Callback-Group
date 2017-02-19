#!/usr/bin/perl

use Test::More;

use strict;

done_testing(2);

require_ok('Callback::Group::Item');

subtest 'create new' => sub {
	my $cb = Callback::Group::Item->new(sub {}, 1);
	ok($cb, 'Creating object');
	can_ok($cb, qw(new run result));
};

# subtest 'getters tests' => sub {
# 	my $task = Task->new($test_frame);
# 	is($task->domain(),$test_domain,'get domain');
# 	is($task->tag(),$test_tag,'get tag');
# };
