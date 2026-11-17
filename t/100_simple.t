use v5.40;
use Test2::V0 '!subtest';
use Test2::Util::Importer 'Test2::Tools::Subtest' => ( subtest_streamed => { -as => 'subtest' } );
use File::Temp qw[tempdir];
use File::Spec;
use lib '../lib', 'lib';

#~ use blib;
use WebUI;
#
subtest _find_browser => sub {
    subtest 'Host Discovery (Real Environment)' => sub {
        my ( $path, $type ) = WebUI::_find_browser();
        if ( defined $path ) {
            ok -e $path, "Found browser at: $path";
            ok( ( $^O eq 'MSWin32' || -x $path ), "Browser executable bit set: $path" );
            isnt $type, WebUI::NoBrowser(), "Type is not NoBrowser (Got ID: $type)";
            diag "Host detected browser: $path (Type: $type)";
        }
        else {
            is $path, undef,              'Path is undef when no browser is installed';
            is $type, WebUI::NoBrowser(), 'Browser type gracefully falls back to NoBrowser()';
            diag 'Clean fallback verified: No GUI browser detected on this system';
        }
        subtest 'Scalar Context' => sub {
            my $path = WebUI::_find_browser();
            if ( defined $path ) {
                ok !ref($path) && !( $path =~ /^\d+$/ ), 'Returns file path in scalar context, not enum ID';
            }
            else {
                is $path, undef, 'Returns undef in scalar context when no browser is found';
            }
        };
    };
    subtest 'Explicit NoBrowser Request' => sub {
        my ( $path, $type ) = WebUI::_find_browser( WebUI::NoBrowser() );
        is $path, undef,              'Requesting NoBrowser() returns undef path';
        is $type, WebUI::NoBrowser(), 'Requesting NoBrowser() returns NoBrowser enum';
    };
    subtest 'Mocked PATH Environments' => sub {
        skip_all 'Mock PATH tests applicable to POSIX only' if $^O eq 'MSWin32' || $^O eq 'darwin';
        subtest 'Empty PATH yields NoBrowser' => sub {
            my $empty_dir = tempdir( CLEANUP => 1 );
            local $ENV{PATH} = $empty_dir;
            my ( $path, $type ) = WebUI::_find_browser( WebUI::AnyBrowser() );
            is $path, undef,              'Empty PATH returns undef path';
            is $type, WebUI::NoBrowser(), 'Empty PATH returns NoBrowser()';
        };
        subtest 'Browser Selection & Filtering' => sub {
            my $mock_dir     = tempdir( CLEANUP => 1 );
            my $fake_chrome  = File::Spec->catfile( $mock_dir, 'google-chrome' );
            my $fake_firefox = File::Spec->catfile( $mock_dir, 'firefox' );
            for my $file ( $fake_chrome, $fake_firefox ) {
                open my $fh, '>', $file or die "Cannot create mock binary $file: $!";
                print $fh "#!/bin/sh\nexit 0;\n";
                close $fh;
                chmod 0755, $file;
            }
            local $ENV{PATH} = $mock_dir;
            subtest AnyBrowser => sub {    # AnyBrowser picks the first encountered candidate
                my ( $any_path, $any_type ) = WebUI::_find_browser( WebUI::AnyBrowser() );
                ok defined($any_path), 'AnyBrowser picked a mock browser';
            };

            # Explicit Firefox request
            subtest Firefox => sub {
                my ( $ff_path, $ff_type ) = WebUI::_find_browser( WebUI::Firefox() );
                is $ff_path, $fake_firefox,    'Explicit Firefox request matched mock firefox';
                is $ff_type, WebUI::Firefox(), 'Matched type is Firefox';
            };
            subtest ChromiumBased => sub {    # ChromiumBased must choose Chrome and ignore Firefox
                my ( $cr_path, $cr_type ) = WebUI::_find_browser( WebUI::ChromiumBased() );
                is $cr_path,   $fake_chrome,    'ChromiumBased matched mock Chrome';
                isnt $cr_path, $fake_firefox,   'ChromiumBased correctly skipped Firefox';
                is $cr_type,   WebUI::Chrome(), 'Matched type is Chrome';
            };
            subtest Fake => sub {             # Non-existent browser in PATH
                my ( $fake_path, $fake_type ) = WebUI::_find_browser( WebUI::Epic() );
                is $fake_path, undef,              'Non-existent browser returns undef';
                is $fake_type, WebUI::NoBrowser(), 'Non-existent browser returns NoBrowser';
            }
        };
    };
};
#
done_testing;
