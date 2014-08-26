package IO::All::Dir;
use IO::All::Base;
extends 'IO::All::Filesys';

# Upgrade from IO::All to IO::All::Dir
use constant upgrade_methods => [qw(dir mkdir)];

sub can_upgrade {
    my ($self, $object) = @_;
    my $location = $object->location;
    return if
        not defined $location or
        not length $location;
    -d $location;
}

sub dir {
    my $self = shift;
    $self->name(shift) if @_;
    return $self;
}

sub mkdir {
    my ($self) = @_;
    my $name = $self->name;
    my $strict = $self->{_strict};
    if (-d $name) {
        return unless $strict;
        $self->throw("Can't mkdir $name. Directory already exists.");
    }
    CORE::mkdir($name) or $self->throw("mkdir $name failed: $!");
}

1;
