use v5.40;
use Test2::V0 '!subtest';
use Test2::Util::Importer 'Test2::Tools::Subtest' => ( subtest_streamed => { -as => 'subtest' } );
use lib '../lib', 'lib';

#~ use blib;
use WebUI;
#
subtest internals => sub {
    my ( $path, $type ) = WebUI::_find_browser();
    if ( defined $path ) {
        ok -e $path, "Found browser at: $path";
        ok( ( $^O eq 'MSWin32' || -x $path ), "Browser executable bit set: $path" );
        isnt $type, WebUI::NoBrowser(), "Type is not NoBrowser (Got ID: $type)";
        diag "Host detected browser: $path (Type: $type)";
    }
    else {
        # Graceful handling for headless/server runners
        is $path, undef,              'Path is undef when no browser is installed';
        is $type, WebUI::NoBrowser(), 'Browser type gracefully falls back to NoBrowser()';
        diag 'Verified clean fallback: No GUI browser detected on this system';
    }
};
#
done_testing;
