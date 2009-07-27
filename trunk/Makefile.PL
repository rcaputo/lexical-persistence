# $Id$

use warnings;
use strict;

use ExtUtils::MakeMaker;

### Touch files that will be generated at "make dist" time.
### ExtUtils::MakeMaker and Module::Build will complain about them if
### they aren't present now.

foreach my $touched (qw(CHANGES META.yml README)) {
	open TOUCH, ">>", $touched and close TOUCH;
}

### Generate Makefile.PL.

WriteMakefile(
	NAME => 'Lexical::Persistence',
	AUTHOR => 'Rocco Caputo <rcaputo@cpan.org>',
	ABSTRACT => 'Persistent, continuation-like contexts for lexical variables.',
	VERSION_FROM => 'lib/Lexical/Persistence.pm',
	LICENSE => 'perl',
	META_ADD     => {
		resources  => {
			license    => 'http://dev.perl.org/licenses/',
			repository => 'http://thirdlobe.com/svn/lex-per/trunk'
		},
	},
	dist           => {
		COMPRESS => 'gzip -9f',
		SUFFIX   => 'gz',
		PREOP    => (
			'../repo-tools/svn-log.perl | ' .
			'/usr/bin/tee ./$(DISTNAME)-$(VERSION)/CHANGES > ./CHANGES; ' .
			'LANG=C perldoc lib/Lexical/Persistence.pm | ' .
			'/usr/bin/tee ./$(DISTNAME)-$(VERSION)/README > ./README'
		),
	},

	PREREQ_PM => {
		'Devel::LexAlias' => 0.04,
		'PadWalker' => 1.1,
	},
);

1;
