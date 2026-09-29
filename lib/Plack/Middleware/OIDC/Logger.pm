package Plack::Middleware::OIDC::Logger;
use 5.014;
use strict;
use warnings;

=encoding utf8

=head1 NAME

Plack::Middleware::OIDC::Logger - Minimal default logger for Plack::Middleware::OIDC

=head1 DESCRIPTION

L<OIDC::Client> and L<OIDC::Client::Plugin> require a logger object that
implements the C<debug>, C<info>, C<error> and (C<warning> or C<warn>)
methods (see L<OIDC::Client::Role::LoggerWrapper>).

Unlike Mojolicious, Catalyst or Dancer2, Plack does not provide a logger
out of the box, so this small class is used by default, writing to
C<STDERR> (or to C<$env->{'psgix.logger'}> if available). You can
provide your own logger object instead via the C<log> option of
L<Plack::Middleware::OIDC>, as long as it implements the same interface.

=head1 METHODS

=head2 new( %args )

Optional C<env> argument: if given and C<$env->{'psgix.logger'}> is
set, messages are sent there instead of C<STDERR>.

=cut

sub new {
  my ($class, %args) = @_;

  return bless { env => $args{env} }, $class;
}

sub _log {
  my ($self, $level, $message) = @_;

  my $env = $self->{env};
  if ($env && $env->{'psgix.logger'}) {
    $env->{'psgix.logger'}->({ level => $level, message => $message });
    return;
  }

  print STDERR "[$level] $message\n";
  return;
}

sub debug   { my $self = shift; $self->_log('debug',   @_); return; }
sub info    { my $self = shift; $self->_log('info',    @_); return; }
sub warning { my $self = shift; $self->_log('warn',    @_); return; }
sub warn    { my $self = shift; $self->_log('warn',    @_); return; }
sub error   { my $self = shift; $self->_log('error',   @_); return; }

1;
