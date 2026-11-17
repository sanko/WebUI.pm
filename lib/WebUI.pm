package WebUI v0.0.1 {
    use v5.40;
    use feature 'class';
    no warnings qw[experimental::class];
    use Affix           qw[:all];
    use Acme::Parataxis qw[];
    #
    use Data::Printer;
    #
    my $WEBUI_MAX_IDS = 999999;    # For now
    my $WEBUI_ID      = 0;
    #
    sub new_window() { }

    sub new_window_id($win) {
        return if $win > $WEBUI_MAX_IDS;
    }

    sub get_new_window_id() {
        return $WEBUI_ID++;
    }

    sub show( $win, $uri ) {
    }
    sub show_browser( $win, $uri )                { }
    sub show_wv( $win, $uri )                     { }
    sub show_client( $win, $uri )                 { }
    sub start_server( $win, $path )               { }
    sub close($win)                               { }
    sub close_client($event)                      { }
    sub destroy($win)                             { }
    sub exit()                                    { }
    sub wait()                                    { }
    sub wait_async()                              { }
    sub is_shown($win)                            { }
    sub focus($win)                               { }
    sub minimize($win)                            { }
    sub maximize($win)                            { }
    sub set_kiosk( $win, $bool )                  { }
    sub set_size( $win, $width, $height )         { }
    sub set_minimum_size( $win, $width, $height ) { }
    sub set_position( $win, $x, $y )              { }
    sub set_center($win)                          { }
    sub set_hide( $win, $bool )                   { }
    sub set_frameless( $win, $bool )              { }
    sub set_transparent( $win, $bool )            { }
    sub set_resizable( $win, $bool )              { }
    sub set_icon( $win, $icon, $icon_type )       { }
    sub set_high_contrast( $win, $bool )          { }
    sub is_high_contrast()                        { }
    sub set_custom_parameters( $win, $params )    { }
    sub set_close_handler_wv( $win, $callback )   { }
    sub navigate( $win, $uri )                    { }
    sub navigate_client( $win, $uri )             { }
    sub get_url($win)                             { }
    sub open_url($url)                            { }
    sub set_public( $win, $bool )                 { }
    sub bind( $win, $element, $func )             { }

    class WebUI::Event {    # XXX - Should this be a Struct[...] instead?
        field $window        : param : reader;    # The window object number
        field $event_type    : param : reader;    # Event type
        field $element       : param : reader;    #HTML element ID
        field $event_number  : param : reader;    # Internal WebUI
        field $bind_id       : param : reader;    # Bind ID
        field $client_id     : param : reader;    # Client's unique ID
        field $connection_id : param : reader;    # Client's connection ID
        field $cookies       : param : reader;    # Client's full cookies

        #
        method get_count()           { }
        method get_int()             { }
        method get_int_at($index)    { }
        method get_float()           { }
        method get_float_at($index)  { }
        method get_string()          { }
        method get_string_at($index) { }
        method get_bool()            { }
        method get_bool_at($index)   { }
        method get_size()            { }
        method get_size_at($index)   { }
        method get_bytes()           { }
        method get_bytes_at($index)  { }
        method return_int($val)      { }
        method return_float($val)    { }
        method return_string($val)   { }
        method return_bool($val)     { }
    }
    typedef Runtime => Enum [qw[Deno Bun NodeJS None]];
    typedef Event => Enum [
        [ 'WEBUI_EVENT_DISCONNECTED' => 0 ],    # Window disconnection event
        'WEBUI_EVENT_CONNECTED',                # Window connection event
        'WEBUI_EVENT_MOUSE_CLICK',              # Mouse click event
        'WEBUI_EVENT_NAVIGATION',               # Window navigation event
        'WEBUI_EVENT_CALLBACK'                  # Function call event
    ];
    typedef Browser => Enum [
        'NoBrowser',                            # 0. No web browser
        'AnyBrowser',                           # 1. Default recommended web browser
        'Chrome',                               # 2. Google Chrome
        'Firefox',                              # 3. Mozilla Firefox
        'Edge',                                 # 4. Microsoft Edge
        'Safari',                               # 5. Apple Safari
        'Chromium',                             # 6. The Chromium Project
        'Opera',                                # 7. Opera Browser
        'Brave',                                # 8. The Brave Browser
        'Vivaldi',                              # 9. The Vivaldi Browser
        'Epic',                                 # 10. The Epic Browser
        'Yandex',                               # 11. The Yandex Browser
        'ChromiumBased',                        # 12. Any Chromium based browser
        'Webview'                               # 13. WebView (Non-web-browser)
    ];
    typedef Config => Enum [

        # Wait for browser to connect before show() returns.
        # Default: true
        [ show_wait_connection => 0 ],

        # Process all UI events in a single blocking thread (true)
        # or each in a new thread (false). Applies to all windows.
        # Default: false
        'ui_event_blocking',

        # Auto-refresh the window when any file in the root folder changes.
        # Default: false
        'folder_monitor',

        # Allow multiple browser clients to connect to the same window.
        # Useful for web apps. See documentation for details.
        # Default: false
        'multi_client',

        # Use WebUI auth cookies to identify clients and block unauthorized
        # URL access. Keep true to restrict access to one client at a time.
        # Default: true
        'use_cookies',

        # Set to true if your backend uses async operations and sets
        # responses via webui_return_x() after the callback returns.
        # Default: false
        'asynchronous_response'
    ];
    sub set_context( $win, $element, $context ) { }
    sub get_context($event)                     { }
    sub set_event_blocking( $win, $bool )       { }
    #
    sub set_config( $option, $status ) { }
    sub set_timeout($seconds)          { }
    sub run( $win, $script )           { }
    sub run_client( $event, $script )  { }

    sub script( $win, $script, $timeout ) {

        # Actual call is $win, $script, $timeout, $buffer, $buffer_length
    }

    sub script_client( $win, $script, $timeout ) {

        # Actual call is $win, $script, $timeout, $buffer, $buffer_length
    }
    sub set_runtime( $win, $runtime ) { }

    sub send_raw( $win, $function, $raw ) {

        # Actual call is $win, $unction, $raw, $length
    }

    sub send_raw_client( $win, $function, $raw ) {

        # Actual call is $win, $unction, $raw, $length
    }
    sub set_file_handler( $win, $handler )        { }
    sub set_file_handler_window( $win, $handler ) { }
    sub set_root_folder( $win, $path )            { }
    sub set_default_root_folder($path)            { }
    sub get_mime_type($file)                      { }

    sub get_best_browser($win) {
    }
    sub browser_exist($id)                { }
    sub set_profile( $win, $name, $path ) { }
    sub set_proxy( $win, $proxy )         { }
    sub set_browser_folder($path)         { }
    sub delete_profile($win)              { }
    sub delete_all_profiles()             { }
    sub get_port($win)                    { }
    sub set_port($win)                    { }
    sub get_free_port()                   { }
    sub get_parent_process_id($win)       { }
    sub get_child_process_id($win)        { }

    sub get_hwnd($win) {

        # Win32: HWND hwnd = (HWND) get_hwnd($win);
        # Linux: GtkWindow = (GtkWindow*) get_hwnd($win);
    }
    sub get_win32_hwnd($win)                               { }
    sub set_tls_certificate( $cert_pem, $private_key_pem ) { }
    sub set_logger( $func, $user_data )                    { }
    sub get_last_error_number()                            { }
    sub clean()                                            { }

    # Utils...
    sub _find_browser ( $desired_browser = AnyBrowser() ) {
        my @candidates;
        if ( $^O eq 'MSWin32' ) {
            my $sys_drive = $ENV{'SystemDrive'} || 'C:';
            my @roots     = grep { defined && length && -d } (
                $ENV{'ProgramFiles'},                $ENV{'ProgramFiles(x86)'},
                $ENV{'ProgramW6432'},                $ENV{'LOCALAPPDATA'},
                $ENV{'APPDATA'},                     $sys_drive . '\Program Files',
                $sys_drive . '\Program Files (x86)', 'C:\Program Files',
                'C:\Program Files (x86)'
            );
            my %seen;
            @roots = grep { !$seen{ lc $_ }++ } @roots;
            for my $r (@roots) {
                push @candidates,    #
                    [ Edge(), $r . '\Microsoft\Edge\Application\msedge.exe' ], [ Edge(), $r . '\Microsoft\Edge Beta\Application\msedge.exe' ],
                    [ Edge(), $r . '\Microsoft\Edge Dev\Application\msedge.exe' ],
                    #
                    [ Chrome(), $r . '\Google\Chrome\Application\chrome.exe' ], [ Chromium(), $r . '\Chromium\Application\chrome.exe' ],
                    #
                    [ Brave(),  $r . '\BraveSoftware\Brave-Browser\Application\brave.exe' ], [ Firefox(), $r . '\Mozilla Firefox\firefox.exe' ],
                    [ Opera(),  $r . '\Opera\launcher.exe' ],                                [ Vivaldi(), $r . '\Vivaldi\Application\vivaldi.exe' ],
                    [ Yandex(), $r . '\Yandex\YandexBrowser\Application\browser.exe' ];
            }
            warn;

            # Check Windows Registry App Paths
            my @reg_map = (
                [ Edge(),    'msedge.exe' ],
                [ Chrome(),  'chrome.exe' ],
                [ Brave(),   'brave.exe' ],
                [ Firefox(), 'firefox.exe' ],
                [ Opera(),   'launcher.exe' ],
                [ Vivaldi(), 'vivaldi.exe' ]
            );
            for my $b_type (@reg_map) {
                my $exe = $b_type->[1];
                for my $hive (qw[HKLM HKCU]) {
                    my $out = `reg query "$hive\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\$exe" /ve 2>nul`;
                    if ( $out && $out =~ /REG_SZ\s+(.*)$/mi ) {
                        my $p = $1;
                        $p =~ s/^\s+|\s+$//g;
                        $p =~ s/^"(.*)"$/$1/;
                        push @candidates, [ $b_type->[0], $p ] if $p && -f $p;
                    }
                }
            }
            warn;

            # Check where.exe
            for my $b_type (@reg_map) {
                my $exe = $b_type->[1];
                my $out = `where.exe "$exe" 2>nul`;
                if ($out) {
                    for my $p ( split /\r?\n/, $out ) {
                        $p =~ s/^\s+|\s+$//g;
                        push @candidates, [ $b_type->[0], $p ] if $p && -f $p;
                    }
                }
            }
        }
        elsif ( $^O eq 'darwin' ) {
            @candidates = (
                [ Chrome(),  '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' ],
                [ Edge(),    '/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge' ],
                [ Brave(),   '/Applications/Brave Browser.app/Contents/MacOS/Brave Browser' ],
                [ Firefox(), '/Applications/Firefox.app/Contents/MacOS/firefox' ]
            );
        }
        else {
            my @path_dirs = split( /:/, $ENV{PATH} // '' );
            for my $p (@path_dirs) {
                push @candidates, [ Chrome(), "$p/google-chrome-stable" ], [ Chrome(), "$p/google-chrome" ], [ Chromium(), "$p/chromium" ],
                    [ Edge(), "$p/microsoft-edge-stable" ], [ Brave(), "$p/brave-browser" ], [ Firefox(), "$p/firefox" ];
            }
        }
        warn "[DEBUG] _find_browser looking for desired_browser ID: $desired_browser\n";
        for my $item (@candidates) {
            my ( $b_type, $path ) = @$item;
            my $exists = ( -f $path ) ? 1 : 0;
            warn "[DEBUG] Candidate check -> Type: $b_type, Path: $path (Exists: $exists)\n" if $exists;
            if ( $desired_browser == AnyBrowser() || $desired_browser == ChromiumBased() || $desired_browser == $b_type ) {
                if ($exists) {
                    warn "[DEBUG] FOUND matching browser: $path (Type: $b_type)\n";
                    return ( $path, $b_type );
                }
            }
        }
        warn "[DEBUG] _find_browser could not find a valid browser matching $desired_browser\n";
        return ( undef, NoBrowser() );
    }
};
1;
