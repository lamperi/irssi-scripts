use strict;
use vars qw($VERSION %IRSSI);

use Irssi 20011001;

$VERSION = "0.10";
%IRSSI = (
	authors     => "Toni Fadjukoff",
	contact     => "lamperi@lamperi.name",
	name        => "fix_droid_caps",
	licence     => "Public Domain",
	description => "Converts all uppercase umlauts to lowercase if they are the lone uppercases in the line",
);

sub sig_command_msg {
	my ($cmd, $server, $winitem) = @_;
	my ($param, $target, $data) = $cmd =~ /^(-\S*\s)?(\S*)\s(.*)/;

        if (!($data =~ /[A-Z]/) && (index($data, "Ä") >= 0 || index($data, "Ö") >= 0)) {
            $data =~ s/Ä/ä/;
            $data =~ s/Ö/ö/;
            Irssi::signal_stop();
            Irssi::signal_emit("command msg", "$target $data", $server, $winitem);
        }
}

Irssi::command_bind('msg', 'sig_command_msg');
