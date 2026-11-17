use v5.40;
use Test2::V0 '!subtest';
use Test2::Util::Importer 'Test2::Tools::Subtest' => ( subtest_streamed => { -as => 'subtest' } );
use lib '../lib', 'lib';

#~ use blib;
use WebUI;
#
subtest internals => sub {
    my ( $path, $type ) = WebUI::_find_browser();
    is $path, D(), '_find_browser()' and diag $path;
};
#
done_testing;
