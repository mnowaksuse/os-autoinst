# Copyright © 2016 SUSE LLC
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>.

# this is just a stupid console to track if we're connected to the host
# it is used in s390x backend for serial connection

package consoles::sshIucvconn;
use base 'consoles::console';
use strict;
use warnings;
use testapi qw/get_var/;
require IPC::System::Simple;
use autodie qw(:all);
use XML::LibXML;

sub new {
    my ($class, $testapi_console, $args) = @_;
    my $self = $class->SUPER::new($testapi_console, $args);
    return $self;
}

sub activate {
    my ($self) = @_;

    my $hostname = $self->{args}->{hostname};
    my $chan = $self->backend->start_ssh_serial(hostname => $hostname, password => $self->{args}->{password}, username => 'root');
    $chan->exec("iucvconn $hostname hvc0");
}

1;
