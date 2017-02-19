# NAME

Callback::Group - the module helps to operate with groups of callbacks and synchronize results.

# VERSION

Version 0.01

# SYNOPSIS

The module helps you to simplify manage groups of async operations.

                my $cb_group = Callback::Group->new;

                for (0..9) {
                        $cb_group->add_cb( sub { (shift)->done(@_) }, "Callback $_" );
                }
                
                $cb_group->on_each(sub { print "@_\n" });
                
                $cb_group->run

# EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

# SUBROUTINES/METHODS

## new

                my $cb_group = Callback::Group->new;

This method constructs a new [Callback::Group](https://metacpan.org/pod/Callback::Group) object and returns it.

## add\_cb

                $cb_group->add_cb(sub {}, @args)

Method add\_cb constructs a new [Callback::Group::Item](https://metacpan.org/pod/Callback::Group::Item) and add the callback to current callback group.

## run

                $cb_group->run

Method run runs callback group

## on\_last

                $cb_group->on_last(sub{})

Method on\_last add callback on event, when last callback is done.

## on\_first

                $cb_group->on_first(sub{})

Method on\_first add callback on event, when first callback is done.

## on\_each

                $cb_group->on_each(sub{})

Method on\_first add callback on event, when each callback is done.

## on\_done

                $cb_group->on_done(sub{})

Method on\_done add callback on event, when all callbacks is done.

# AUTHOR

Kirill Sysoev, `<k.sysoev at me.com>`

# BUGS

Please report any bugs or feature requests to `k.sysoev at me.com`.

# SUPPORT

You can find documentation for this module with the perldoc command.

                perldoc Callback::Group
