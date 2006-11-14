#!perl
# $Id$

use warnings;
use strict;

use Lexical::Persistence;

use constant CATCHALL_X => 100;
use constant X          => 200;
use constant OTHER_X    => 300;

use Test::More tests => 24;

sub target {
	my ($arg_test, $catchall_x, $x, $other_x, $_j);

	is ( $catchall_x++, CATCHALL_X + $arg_test, "persistent catchall $arg_test" );
	is ( $x++, X + $arg_test, "persistent x $arg_test" );
	is ( $other_x++, OTHER_X + $arg_test, "other x $arg_test" );
	is ( $_j++, 0, "dynamic j $arg_test" );
}

my $state = Lexical::Persistence->new();
$state->set_context( other => { '$x' => OTHER_X } );
$state->set_context( _ => { '$catchall_x' => CATCHALL_X, '$x' => X } );

for my $test (0..2) {
	$state->call(\&target, test => $test);
}

my $thunk = $state->wrap(\&target);
for my $test (3..5) {
	$thunk->(test => $test);
}
