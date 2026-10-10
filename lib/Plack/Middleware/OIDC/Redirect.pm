package Plack::Middleware::OIDC::Redirect;
use 5.020;
use utf8;
use strict;
use warnings;

=encoding utf8

=head1 NAME

Plack::Middleware::OIDC::Redirect - Internal exception class used to signal a redirect

=head1 DESCRIPTION

L<OIDC::Client::Plugin> is designed for frameworks where the current request
has a mutable response object that a controller can alter at any point
(C<$c->redirect_to(...)> in Mojolicious, for example).

PSGI has no such object: the response is simply the return value of the
application coderef. So when application code calls
C<$env->{oidc}->redirect_to_authorize()> or
C<$env->{oidc}->redirect_to_logout()> from deep within its own logic,
there is no direct way to make the enclosing PSGI application return early
with a redirect response.

To work around this, L<Plack::Middleware::OIDC> gives L<OIDC::Client::Plugin>
a C<redirect> coderef that throws an instance of this class instead of
performing the redirection itself. L<Plack::Middleware::OIDC> then wraps the
call to the downstream application in an C<eval>, catches this exception, and
turns it into a real C<302> PSGI response.

This mirrors the way L<Plack::Middleware::HTTPExceptions> turns exception
objects into HTTP responses.

=head1 METHODS

=head2 new( url => $url )

=cut

sub new {
  my ($class, %args) = @_;

  return bless { url => $args{url} }, $class;
}

=head2 url()

Returns the URL to redirect to.

=cut

sub url { return $_[0]->{url} }

1;
