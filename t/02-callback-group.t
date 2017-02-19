#!/usr/bin/perl

use Test::More;

use strict;

done_testing(3);

require_ok('Callback::Group');

subtest 'create new' => sub {
	my $cb = Callback::Group->new();
	ok($cb, 'Creating object');
	can_ok($cb, qw(new run add_cb));
};

subtest 'result callbacks' => sub {
	my $cb_group = Callback::Group->new();
	$cb_group->add_cb( sub { (shift)->done(@_) }, 1 );
	$cb_group->add_cb( sub { (shift)->done(@_) }, 2 );
	$cb_group->add_cb( sub { (shift)->done(@_) }, 3 );

	$cb_group->on_first(sub { is(shift, 1, 'on first callback') });
	$cb_group->on_last(sub { is(shift, 3, 'on last callback') });
	$cb_group->on_done(sub { is(join('', map { join('',@{$_})} @_), '123', 'on done callback') });

	my @result;
	$cb_group->on_each(sub { push @result, shift });
	$cb_group->run();
	is(join('',@result),'123', 'on each callback');
};
