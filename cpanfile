requires 'perl', '5.20.0';

requires 'Carp';
requires 'Clone';
requires 'Plack';
requires 'Scalar::Util';
requires 'OIDC::Client', '1.08';
requires 'Try::Tiny';
requires 'URI';

test_requires 'HTTP::Request::Common';
test_requires 'Test::MockModule', '0.177.0';
test_requires 'Test::More';
test_requires 'URI::QueryParam';

author_requires 'Test::CPAN::Meta';
author_requires 'Test::Perl::Critic';
author_requires 'Test::Vars';
