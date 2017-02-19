package Callback::Group::Item;

use 5.018;
use strict;
use warnings;

=head1 NAME

Callback::Group::Item - callback wrapper for Callback::Group.

=head1 SYNOPSIS

The module helps you to simplify manage groups of async operations.

		my $cb = Callback::Group::Item->new(sub {}, @args, sub {});
		$cb->run


=head1 SUBROUTINES/METHODS

=head2 new

		my $cb_group = Callback::Group::Item->new;

This method constructs a new L<Callback::Group::Item> object and returns it.

=cut

sub new {
	my $class = shift;
	my $cb = shift;
	my $on_result = pop;

	my $self = {
		cb => $cb // sub {},
		args => [@_],
		results => [],
		is_running => 0,
		is_done => 0,
		on_result => $on_result // sub {},
	};

	bless $self, $class;

	return $self;
}


=head2 run

		my $cb_group = Callback::Group::Item->run;

=cut
sub run {
	my $self = shift;
	$self->{is_run} = 1;
	$self->{cb}->($self,@{$self->{args}});
}

=head2 done

=cut
sub done {
	my $self = shift;
	$self->{is_run} = 0;
	$self->{is_done} = 1;
	$self->{results} = [@_];
	$self->{on_result}->($self);
}



=head2 result

=cut
sub result {
	my $self = shift;
	return @{$self->{results}};
}

=head1 AUTHOR

Kirill Sysoev, C<< <k.sysoev at me.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<k.sysoev at me.com>.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

		perldoc Callback::Group::Item

=cut

1; # End of Callback::Group::Item
