use Irssi;
use strict;

use vars qw($VERSION %IRSSI);
$VERSION = '1.00';
%IRSSI = (
    authors	=> 'CaeSpock',
    contact	=> 'cae@CaeSpock.org',
    name	=> 'CaeScript',
    description	=> 'Simple set of aliases and commands' .
                   'Not everything is mine, but i made it possible:P',
    license	=> 'Public Domain',
    url		=> 'http://www.caespock.org/ircsoftware/',
    changed	=> 'Web Feb 13 00:05 BOT 2014',
);
Irssi::theme_register([
    'caescript_loaded', '%R>>%n %_Scriptinfo:%_ Loaded $0 version $1 by $2.'
]);
Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'caescript_loaded', $IRSSI{name}, $VERSION, $IRSSI{authors});
# Some needed stuff
Irssi::command("^SET use_status_window OFF");
#
# Services stuff
#
Irssi::command_bind('nickserv', 'cmd_nickserv');
sub cmd_nickserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("nickserv $data");
  } else {
    Irssi::active_win()->print("NickServ: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('chanserv', 'cmd_chanserv');
sub cmd_chanserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("chanserv $data");
  } else {
    Irssi::active_win()->print("ChanServ: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('memoserv', 'cmd_memoserv');
sub cmd_memoserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("memoserv $data");
  } else {
    Irssi::active_win()->print("MemoServ: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('helpserv', 'cmd_helpserv');
sub cmd_helpserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg helpserv :$data");
  } else {
    Irssi::active_win()->print("HelpServ: Command not given, we can\'t send an empty request");
  }
}
# Whois everyone that sends a query to me
Irssi::signal_add_last('query created', 'sig_query');
sub sig_query() {
  my ($query, $auto) = @_;
  # don't say anything if we did /query,
  # or if query went to active window
  my $refnum = $query->window()->{refnum};
  my $window = Irssi::active_win();
  if ($auto && $refnum != $window->{refnum}) {
    $window->print("Query started with ".$query->{name}." in window $refnum");
    $query->{server}->command("whois ".$query->{name});
  }
}
# This part shows notices into the active channel unless it has its own window.
Irssi::signal_add('print text', 'notice_move');
sub notice_move {

    my ($dest, $text, $stripped) = @_;
    my $server = $dest->{server};

    return if (!$server || !($dest->{level} & MSGLEVEL_NOTICES) || $server->ischannel($dest->{target}));

    my $witem  = $server->window_item_find($dest->{target});
    my $awin = Irssi::active_win();

    return if $witem;

    $awin->print($text, MSGLEVEL_NOTICES);

    Irssi::signal_stop();
}
# This will tell you how many IRCops are in the channel
Irssi::command_bind('ircops', 'cmd_ircops');
sub cmd_ircops {
        my ($data, $server, $channel) = @_;

        my (@list,$text,$num);

        if (!$channel || $channel->{type} ne 'CHANNEL') {
                Irssi::print('No active channel in window');
                return;
        }

        foreach my $nick ($channel->nicks()) {
                if ($nick->{serverop}) {
                        push(@list,$nick->{nick});
                }
        }

        $num = scalar @list;

        if ($num == 0) {
                $text = "no IrcOps on this channel";
        } else {
                $text = "IrcOps (".$num."): ".join(" ",@list);
        }

        $channel->print($text);
}
# This will help detect and count clones in a channel
Irssi::command_bind('clones', 'cmd_clones');
Irssi::settings_add_bool('misc', 'clones_host_only', 1);
Irssi::settings_add_int('misc', 'clones_min_show', 2);
sub cmd_clones {
  my ($data, $server, $channel) = @_;

  my $min = $data =~ /\d/ ? $data : Irssi::settings_get_int('clones_min_show');

  if (!$channel || $channel->{type} ne 'CHANNEL') {
    Irssi::print('No active channel in window');
    return;
  }

  my %hostnames = {};
  my $ident = Irssi::settings_get_bool('clones_host_only');

  foreach my $nick ($channel->nicks()) {
        my $hostname;
        if($ident) {
           ($hostname = $nick->{host}) =~ s/^[^@]+@//;
        }else{
           $hostname = $nick->{host};
        }

        $hostnames{$hostname} ||= [];
        push( @{ $hostnames{$hostname} }, $nick->{nick});
  }

  my $count = 0;
  foreach my $host (keys %hostnames) {
        next unless ref($hostnames{$host}) eq 'ARRAY'; # sometimes a hash is here
    my @clones = @{ $hostnames{$host} };
    if (scalar @clones >= $min) {
      $channel->print('Clones:') if ($count == 0);
      $channel->print("$host: " . join(' ',@clones));
      $count++;
    }
  }

  $channel->print('No clones in channel') if ($count == 0);
}
# Additional aliases
Irssi::command_bind('byeall', 'cmd_byeall');
sub cmd_byeall {
  my ($data, $server, $witem) = @_;
  if ($witem && ($witem->{type} eq "CHANNEL" ||
                        $witem->{type} eq "QUERY")) {
      # there's query/channel active in window
      $witem->command("MSG ".$witem->{name}." Bye to everybody!");
  }
}
Irssi::command_bind('beer', 'cmd_beer');
sub cmd_beer {
  my ($data, $server, $witem) = @_;
  if ($witem && ($witem->{type} eq "CHANNEL" ||
                        $witem->{type} eq "QUERY")) {
      # there's query/channel active in window
      $witem->command("me invites a fine cold Bolivian beer to ".$witem->{name});
  }
}
Irssi::command_bind('cinta', 'cmd_cinta');
sub cmd_cinta {
  my ($data, $server, $witem) = @_;
  if ($witem && ($witem->{type} eq "CHANNEL" ||
                        $witem->{type} eq "QUERY")) {
      # there's query/channel active in window
      $witem->command("msg ".$witem->{name}." 1,1 1,2 1,3 1,4 1,5 1,6 1,7 1,8 1,9 1,10 1,11 1,12 1,13 1,14 1,15 1,17 1,18 8,1 $data1,1 1,2 1,3 1,4 1,5 1,6 1,7 1,8 1,9 1,10 1,11 1,12 1,13 1,14 1,15 1,17 1,18 1,19");
  }
}
Irssi::command_bind('csopme', 'cmd_csopme');
sub cmd_csopme {
  my ($data, $server, $witem) = @_;
  $witem->command("chanserv op ".$witem->{name}." ".$server->{nick});
}
Irssi::command_bind('hora', 'cmd_hora');
Irssi::command_bind('date', 'cmd_hora');
Irssi::command_bind('time', 'cmd_hora');
sub cmd_hora {
  my ($data, $server, $witem) = @_;
  my $output = `date`;
  if ($witem && ($witem->{type} eq "CHANNEL" ||
                        $witem->{type} eq "QUERY")) {
      # there's query/channel active in window
      $witem->command("msg ".$witem->{name}." Current Date Time: $output");
  }
}
Irssi::command_bind('o', 'cmd_o');
sub cmd_o {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("mode ".$witem->{name}." +o $data");
  }
}
Irssi::command_bind('ops', 'cmd_onotice');
Irssi::command_bind('onotice', 'cmd_onotice');
Irssi::command_bind('opnotice', 'cmd_onotice');
sub cmd_onotice {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("notice @".$witem->{name}." [Ops] $data");
    # Irssi::active_win()->print("-> [Ops] $data");
  }
}
Irssi::command_bind('opsv', 'cmd_ovnotice');
Irssi::command_bind('opv', 'cmd_ovnotice');
Irssi::command_bind('opvnotice', 'cmd_ovnotice');
sub cmd_ovnotice {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("notice "."@"."+".$witem->{name}." [OpsV] $data");
    # Irssi::active_win()->print("-> [OpsV] $data");
  }
}
Irssi::command_bind('so', 'cmd_so');
sub cmd_so {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("mode ".$witem->{name}." -o $data");
  }
}
Irssi::command_bind('sv', 'cmd_sv');
sub cmd_sv {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("mode ".$witem->{name}." -v $data");
  }
}
Irssi::command_bind('v', 'cmd_v');
sub cmd_v {
  my ($data, $server, $witem) = @_;
  if ($witem && $witem->{type} eq "CHANNEL") {
    $witem->command("mode ".$witem->{name}." +v $data");
  }
}
Irssi::command_bind('ver', 'cmd_ver');
sub cmd_ver {
  my ($data, $server, $witem) = @_;
  if ($witem && ($witem->{type} eq "CHANNEL" ||
                        $witem->{type} eq "QUERY")) {
      # there's query/channel active in window
      $witem->command("msg ".$witem->{name}." I'm ussing Irssi powered by ".$IRSSI{name}." v.".$VERSION." by ".$IRSSI{authors}.".");
      Irssi::signal_stop();
  }
}
# In case we oper, lets load IRCopTools
Irssi::signal_add('event 381', 'load_ircoptools');
sub load_ircoptools {
  my ($server, $data, $server_name) = @_;
  my $nick = Irssi::active_server()->{'nick'};
  Irssi::command("script load ircoptools.pl");
  $server->send_raw("mode $nick +aAb");
}

