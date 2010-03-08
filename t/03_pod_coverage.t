# $Id: 02_pod_coverage.t 2139 2006-10-01 17:07:59Z rcaputo $
# vim: filetype=perl

use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage"
if $@;
all_pod_coverage_ok();
