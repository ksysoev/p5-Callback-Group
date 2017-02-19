package Callback::Group;

use 5.018;
use strict;
use warnings;

use Callback::Group::Item;

=head1 NAME

Callback::Group - the module helps to operate with groups of callbacks and synchronize results.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

The module helps you to simplify manage groups of async operations.

		my $cb_group = Callback::Group->new;

		for (0..9) {
			$cb_group->add_cb( sub { (shift)->done(@_) }, "Callback $_" );
		}
		
		$cb_group->on_each(sub { print "@_\n" });
		
		$cb_group->run


=head1 SUBROUTINES/METHODS

=head2 new

		my $cb_group = Callback::Group->new;

This method constructs a new L<Callback::Group> object and returns it.

=cut

sub new {
	my $class = shift;
	
	my $self = {
		cb_list => [],
		is_running => 0,
		is_done => 0,
		done_counter => 0,
		on_last => sub {},
		on_first => sub {},
		on_each => sub {},
		on_done => sub {},	
	};

	bless $self, $class;

	return $self;
}

=head2 add_cb

		$cb_group->add_cb(sub {}, @args)

Method add_cb constructs a new L<Callback::Group::Item> and add the callback to current callback group.



=cut

sub add_cb {
	my $self = shift;
	push @{$self->{cb_list}}, Callback::Group::Item->new(@_ , sub { $self->_on_cb_result(@_) });
	return $self;
}


=head2 run

		$cb_group->run

Method run runs callback group

=cut

sub run {
	my $self = shift;
	$self->{is_running} = 1;
	for my $cb (@{$self->{cb_list}}) { $cb->run() }
	return $self;
}

=head2 on_last

		$cb_group->on_last(sub{})

Method on_last add callback on event, when last callback is done.

=cut

sub on_last { $_[0]->_add_event('on_last', $_[1]) }

=head2 on_first

		$cb_group->on_first(sub{})

Method on_first add callback on event, when first callback is done.

=cut

sub on_first { $_[0]->_add_event('on_first', $_[1]) }

=head2 on_each

		$cb_group->on_each(sub{})

Method on_first add callback on event, when each callback is done.

=cut

sub on_each { $_[0]->_add_event('on_each', $_[1]) }

=head2 on_done

		$cb_group->on_done(sub{})

Method on_done add callback on event, when all callbacks is done.

=cut

sub on_done { $_[0]->_add_event('on_done', $_[1]) }

sub _add_event {
	my $self = shift;
	my $event = shift;
	my $cb = shift;
	die 'first argument needs to be code reference' unless (ref $cb eq ref sub {});
	$self->{$event} = $cb;
	return $self;
}

sub _on_cb_result {
	my $self = shift;
	my $cb = shift;
	$self->{done_counter}++;

	$self->{on_each}->($cb->result());
	if ($self->{done_counter} == 1) {
		$self->{on_first}->($cb->result());
	} elsif ($self->{done_counter} == @{$self->{cb_list}}) {
		$self->{on_last}->($cb->result());
		$self->{on_done}->(map {[$_->result()]} @{$self->{cb_list}});
	}
}

=head1 AUTHOR

Kirill Sysoev, C<< <k.sysoev at me.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<k.sysoev at me.com>.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

		perldoc Callback::Group

=cut

1; # End of Callback::Group
