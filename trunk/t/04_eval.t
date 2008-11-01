#!perl
# $Id$

use warnings;
use strict;

use Lexical::Persistence;

use Test::More tests => 9;

my $lp = Lexical::Persistence->new();

is( $lp->eval( '1 + 2' ), 3, 'constant eval' );

$lp->eval( 'my $three = 3' );
is_deeply( $lp->get_context('_'), { '$three' => 3 }, 'eval sets context' );

my $code = $lp->compile( '$three' );
is( ref $code, 'CODE', 'compile yields a CODE ref' );

is( $lp->call( $code ), 3, 'CODE ref yields the right result' );

is( $lp->eval( '$three + 4' ), 7, 'eval still persists' );

$lp->eval( '$three = 10' );
is( $lp->eval( '$three' ), 10, 'eval updates' );

$lp->eval( 'my @list' );
is_deeply( $lp->get_context('_'), { '$three' => 10, '@list' => [], }, 'eval can add new variables' );

$code = $lp->compile( '$four' );
my $err = "$@";

is( $code, undef, 'syntax error makes eval return undef' );
like( $err, qr/^Global symbol "\$four" requires explicit package name/, 'syntax error complains about variable names' );
