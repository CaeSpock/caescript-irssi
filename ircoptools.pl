use Irssi;
use strict;

use vars qw($VERSION %IRSSI);
$VERSION = '1.11';
%IRSSI = (
    authors     => 'CaeSpock',
    contact     => 'cae@CaeSpock.org',
    name        => 'IRCopTools',
    description => 'Simple set of aliases and commands' .
                   'Not everything is mine, but i made it possible:P',
    license     => 'Public Domain',
    url         => 'http://www.caespock.org/ircsoftware/',
    changed     => 'Web Feb 13 00:05 BOT 2014',
);
Irssi::theme_register([
    'ircoptools_loaded', '%R>>%n %_Scriptinfo:%_ Loaded $0 version $1 by $2.'
]);
Irssi::printformat(MSGLEVEL_CLIENTCRAP, 'ircoptools_loaded', $IRSSI{name}, $VERSION, $IRSSI{authors});
#
# Variables
#
# Main Cloneaddress repository
my ($cloneaddress) = "none\@none.com";
my ($cloneaddress2) = "none\@none.com";

# Main Operator Service
my ($operservice) = 'OperServ';
# Default Akill time
my ($akilltime) = 30;
# Warning messages
my ($anmsg) = 'Hi, I\'m a member of DALnet\'s SAbuse (Services Abuse) team and that entry you just placed is considered services abuse. Please remove it, thanks. For more information please visit http://kline.dal.net/sabuse';
my ($wmmsg) = 'Hello, I\'m a DALnet Services Abuse Team representative. Please stop trying to hack that password. For help with lost passwords please visit #OperHelp. Further password cracking attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason English/Spanish for /kfl and /kflsp , kill for flooding
my ($kflmsg) = 'Flooding is not permitted. Please stop flooding.';
my ($kflspmsg) = 'Flood: El flood NO esta permitido. Por favor deja de floodear.';
# Reason English/Spanish for kh/khsp , kill for harrassment
my ($khmsg) = 'Harassment is not permitted. Please stop doing it.';
my ($khspmsg) = 'Harassment: El acosar no esta permitido aca. Por favor deja de hacerlo.';
# Reason English/Spanish for km/kmsp , kill for mass invites
my ($kmmsg) = '[ma/inv] Mass Messaging / Inviting is not allowed on DALnet. See http://kline.dal.net/massads/mup.htm';
my ($kmspmsg) = 'Mass Invites: Las invitaciones masivas NO estápermitidas';
# Reason and time for /afs (Flooding Services by SABUSE)
my ($afstime) = 30;
my ($afsmsg) = '[SAbuse/SFlood] Flooding services. Please stop flooding services. Further services flood attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason and time for /afs (Ping Flooding Services by SABUSE)
my ($apstime) = 30;
my ($apsmsg) = '[SAbuse/SPing] Flooding services with pings. Please stop flooding services with pings. Further services flood attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason and time for /ahp (Trying to hack passwords by SABUSE)
my ($ahptime) = 30;
my ($ahpmsg) = '[SAbuse/PCrack] Password cracking is not allowed on DALnet. For help with lost passwords please visit #OperHelp. Further password cracking attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason and time for /ahp2 (Trying to hack password via email by SABUSE)
my ($ahp2time) = 30;
my ($ahp2msg) = '[SAbuse/PECrack] Password cracking via E-mail is not allowed on DALnet. For help with lost passwords please visit #OperHelp. Further password cracking attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason and time for /aif (SAbuse: info flood)
my ($aiftime) = 30;
my ($aifmsg) = '[SAbuse/IFlood] Please stop flooding services with all those INFOs. What are you trying to find out? Further services flood attempts may result in a permanent ban and/or your ISP being contacted.';
# Reason and time for /asi (Broken Identify Script by SABUSE)
my ($asitime) = 30;
my ($asimsg) = '[SAbuse/IDFlood] Your identify script is flooding services with identifications to the same nick/#channel over and over. Please fix it ASAP or you will be considered flooding services.';
# Reason and time for /ac (clones)
my ($actime) = 30;
my ($acmsg) = '[exp/clone] Clones are not permitted, go to http://kline.dal.net/exploits/akills.htm';
# Reason and time for /ams (Mass Invites)
my ($amstime) = 30;
my ($amsmsg) = '[ma/inv] Mass Messaging / Inviting is not allowed on DALnet. See http://kline.dal.net/massads/mup.htm';
# Reason and time for /amw (Mass advertising web)
my ($amwtime) = 30;
my ($amwmsg) = '[ma/web] Web Site or Server Advertising is not allowed on DALnet. If you continue, we\'ll notify your web provider and ISP. See http://kline.dal.net/massads/mup.htm';
# Reason and time for /afl (Flood)
my ($afltime) = 30;
my ($aflmsg) = '[Flood] Flooding is NOT permitted';
# Reason and time for /ahs (Harassment)
my ($ahstime) = 30;
my ($ahsmsg) = 'Harassment is NOT permitted';
# Reason and time for /anc (Nick Chasing)
my ($anctime) = 30;
my ($ancmsg) = '[SAbuse/NCh] Nick Chasing is NOT permitted';
# Reason and time for /acl (Nick Colliding)
my ($acltime) = 30;
my ($aclpmsg) = '[SAbuse/NCL] You are colliding over and over, over the same nick. Fix your identify script.Maybe its enforced. Try using /nickserv release nick pass <- Please fix your script';
# Reason and time for /afn - Akill for Trying to use a forbidden nick
my ($afntime) = 30;
my ($afnmsg) = '[SAbuse/FDN] You are trying to use a forbidden nick over and over. Maybe its enforced. Try using /nickserv release nick pass <- Please fix your script';
# Reason and time for /asa (Services Abuse)
my ($asatime) = 30;
my ($asamsg) = '[SAbuse/Abuse] Stop abusing services commands';
# Reason and time for /ats (Trojan Send)
my ($atstime) = 30;
my ($atsmsg) = '[Exp/Trojan] Your PC and/or your IRC Client has been infected by a virus or trojan horse program. Please visit http://kline.dal.net/exploits/akills.htm for more info';
# Reason and time for /atssp - Spanish (Trojan Send)
my ($atssptime) = 30;
my ($atsspmsg) = '[Exp/Trojan] Tu PC y/o tu cliente de IRC estan infectados con un virus trojano. Por favor reemplaza tu cliente IRC o visita http://kline.dal.net/exploits/akills.htm para mas informacion';
#
# Windows
#
my $server = Irssi::active_server()->{'tag'};
my $windowname = Irssi::window_find_name('Kills');
if (!$windowname) {
  Irssi::command("window new hidden");
  Irssi::command("window name Kills");
  Irssi::command("window server $server");
}
my $windowname = Irssi::window_find_name('Network');
if (!$windowname) {
  Irssi::command("window new hidden");
  Irssi::command("window name Network");
  Irssi::command("window server $server");
}
my $windowname = Irssi::window_find_name('Services');
if (!$windowname) {
  Irssi::command("window new hidden");
  Irssi::command("window name Services");
  Irssi::command("window server $server");
}
my $windowname = Irssi::window_find_name('Globals');
if (!$windowname) {
  Irssi::command("window new hidden");
  Irssi::command("window name Globals");
  Irssi::command("window server $server");
}
#
# Server messages
#
Irssi::signal_add("event notice", "event_server_notice");
sub event_server_notice {
  my ($server, $data, $nick, $address) = @_;
  my ($target, $text) = $data =~ /^(\S*)\s+:(.*)$/;
  my (@text) = split(/ /, $text);

  return if ($address or $nick !~ /\./);
  if ($text =~ /^\*\*\* ChatOps -- from/) {
    my (@fa) = join(" ", splice(@text,4));
    my $windowname = Irssi::window_find_name('Globals');
    $windowname->print("%B[C]%n @fa", MSGLEVEL_SNOTES);
  } elsif ($text =~ /^\*\*\* LocOps -- from/) {
    my (@fa) = join(" ", splice(@text,4));
    my $windowname = Irssi::window_find_name('Globals');
    $windowname->print("%G[L]%n @fa", MSGLEVEL_SNOTES);
  } elsif ($text =~ /^\*\*\* Global -- from/) {
    if ( ($text[4] =~ /^OperServ:/) || ($text[4] =~ /^ChanServ:/) || ($text[4] =~ /^NickServ:/) || ($text[4] =~ /^MemoServ:/) 
      || ($text[4] =~ /^RootServ:/) || ($text[4] =~ /^StatServ:/) || ($text[4] =~ /^HelpServ:/) ) {
      my $windowname = Irssi::window_find_name('Services');
      my (@fa) = join(" ", splice(@text, 5));
      $windowname->print("%R[$text[4]]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[4] =~ /^OperServ2:/) {
      my $windowname = Irssi::window_find_name('Services');
      if (($text[5] =~ /^Possible/) && ($text[6] =~ /^vhost/) ) {
        my (@clonehost) = $text[11];
        $cloneaddress2 = $text[11];
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%G[Clones]%n @fa %C[ALT-L to scan]%n", MSGLEVEL_SNOTES);
      } elsif (($text[5] =~ /^Possible/) && ($text[6] =~ /^nick\+gecos/) ) {
        my (@clonehost) = $text[11];
        $cloneaddress = $text[11];
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%G[Clones]%n @fa %C[ALT-C to scan]%n", MSGLEVEL_SNOTES);
      } elsif (($text[5] =~ /^Possible/) && ($text[6] =~ /^uname\+gecos/) ) {
        my (@clonehost) = $text[11];
        $cloneaddress = $text[11];
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%G[Clones]%n @fa %C[ALT-C to scan]%n", MSGLEVEL_SNOTES);
      } elsif (($text[5] =~ /^Possible/) && ($text[6] =~ /^drones:/) ) {
        my (@clonehost) = $text[10];
        $cloneaddress = $text[10];
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%G[Drones]%n @fa %C[ALT-C to scan]%n", MSGLEVEL_SNOTES);
      } elsif (($text[5] =~ /^Possible/) && ($text[6] =~ /^clones:/) ) {
        my (@clonehost) = $text[10];
        $cloneaddress = $text[10];
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%G[Clones]%n @fa %C[ALT-C to scan]%n", MSGLEVEL_SNOTES);
      } else {
        my (@fa) = join(" ", splice(@text, 5));
        $windowname->print("%R[$text[4]]%n @fa", MSGLEVEL_SNOTES);
      }
    } elsif ($text[4] =~ /^stats.dal.net:/) {
      my $windowname = Irssi::window_find_name('Services');
      my (@fa) = join(" ", splice(@text, 5));
      $windowname->print("%R[Stats]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[4] =~ /^services.dal.net:/) {
      my $windowname = Irssi::window_find_name('Services');
      my (@fa) = join(" ", splice(@text, 5));
      $windowname->print("%R[Services]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[4] =~ /^services2.dal.net:/) {
      my $windowname = Irssi::window_find_name('Services');
      my (@fa) = join(" ", splice(@text, 5));
      $windowname->print("%R[Services2]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[4] =~ /^services-redundant.dal.net:/) {
      my $windowname = Irssi::window_find_name('Services');
      my (@fa) = join(" ", splice(@text, 5));
      $windowname->print("%R[Redundant Services]%n @fa", MSGLEVEL_SNOTES);
    } else {
      my $windowname = Irssi::window_find_name('Globals');
      my (@fa) = join(" ", splice(@text, 4));
      $windowname->print("%R[G]%n @fa", MSGLEVEL_SNOTES);
    }
  } elsif ($text =~ /^\*\*\* Routing -- from/) {
    my $windowname = Irssi::window_find_name('Network');
    my (@fa) = join(" ", splice(@text, 4));
    $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
  } elsif ($text =~ /^\*\*\* Connecting to/) {
    my $windowname = Irssi::window_find_name('Network');
    my (@fa) = join(" ", splice(@text, 1));
    $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
  } elsif ($text =~ /^\*\*\* Notice -- /) {
    if ($text[3] =~ /^salmon/ && $text[4] =~ /^added/) {
      # Ignore this
    } elsif ($text[3] =~ /BOPM/ && $text[4] =~ /^added/) {
      # Ignore this
    } elsif ($text[8] =~ /^k\-line/) {
      my $windowname = Irssi::window_find_name('Kills');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[+K]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[3] =~ /^k\-line/ && $text[4] =~ /^active/) {
      # Ignore this
    } elsif ($text[3] =~ /^autokill/ && $text[4] =~ /^active/) {
      # Ignore this
    } elsif ($text =~ /rehash/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[N]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /reloading ircd/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[N]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Forbidding restricted/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[F]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[3] =~ /^clone/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%B[C]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text[3] =~ /^Rejecting/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[R]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Received KILL message for/) {
      my $windowname = Irssi::window_find_name('Kills');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[k]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Failed OPER attempt by/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[O]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Failed OPERMASK attempt by/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[O]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /New Max Local Clients/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[N]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /names abuser/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[N]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /is now operator/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[O]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /has masked their hostname/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[O]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Initiating diffie-hellman key exchange with/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Diffie-Hellman exchange with/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Invalid hostname for/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Ghosted:/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /was connected for/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /Lost Connect block for/) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Routing]%n @fa", MSGLEVEL_SNOTES);
    } elsif ($text =~ /has removed the K\-Line for/) {
      my $windowname = Irssi::window_find_name('Kills');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[-K]%n @fa", MSGLEVEL_SNOTES);
    } else {
      my $windowname = Irssi::window_find_name('Raw');
      if (!$windowname) {
        my $server = Irssi::active_server()->{'tag'};
        Irssi::command("window new hidden");
        Irssi::command("window name Raw");
        Irssi::command("window server $server");
      }
      my $windowname = Irssi::window_find_name('Raw');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%G[Notice]%n @fa", MSGLEVEL_SNOTES);
    }
  } elsif ($text =~ /^\*\*\* Admin -- /) {
      my $windowname = Irssi::window_find_name('Network');
      my (@fa) = join(" ", splice(@text, 3));
      $windowname->print("%R[Admin]%n @fa", MSGLEVEL_SNOTES);
  } elsif (( $text[1] =~ /invited/) && ($text =~ /into channel/)) {
    Irssi::active_win()->print("%G>>%n $text", MSGLEVEL_SNOTES);
  } elsif ($text =~ /^You didn\'t need to use \/SAJOIN for/) {
    my $windowname = Irssi::window_find_name('Services');
    $windowname->print("%G[N]%n $text", MSGLEVEL_SNOTES);
  } else {
    my $windowname = Irssi::window_find_name('Raw');
    if (!$windowname) {
      my $server = Irssi::active_server()->{'tag'};
      Irssi::command("window new hidden");
      Irssi::command("window name Raw");
      Irssi::command("window server $server");
    }
    my $windowname = Irssi::window_find_name('Raw');
    $windowname->print("%G[Raw]%n $text", MSGLEVEL_SNOTES);
  }
  Irssi::signal_stop();
}
#
# Aliases
#
Irssi::command_bind('ac', 'cmd_ac');
sub cmd_ac {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $actime $data $acmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /ac <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('afl', 'cmd_afl');
sub cmd_afl {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $afltime $data $aflmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /afl <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('afn', 'cmd_afn');
sub cmd_afn {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $afntime $data $afnmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /afn <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('afs', 'cmd_afs');
sub cmd_afs {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $afstime $data $afsmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /afs <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('ahp', 'cmd_ahp');
sub cmd_ahp {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $ahptime $data $ahpmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /ahp <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('ahp2', 'cmd_ahp2');
sub cmd_ahp2 {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $ahp2time $data $ahp2msg");
  } else {
    Irssi::active_win()->print("*** Usage: /ahp2 <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('aif', 'cmd_aif');
sub cmd_aif {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $aiftime $data $aifmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /aif <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('ahs', 'cmd_ahs');
sub cmd_ahs {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $ahstime $data $ahsmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /ahs <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('an', 'cmd_an');
sub cmd_an {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $data :$anmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /an <nick>");
  }
}
Irssi::command_bind('akill', 'cmd_akill');
sub cmd_akill {
  my ($data, $server, $channel) = @_;
  my (@data) = split(/ /, $data);
  if ($data) {
    if ( $data[0] =~ /\./) {
      my (@fa) = join(" ", splice(@data, 1));
      $server->send_raw("privmsg $operservice :autokill time $akilltime $data");
    } else {
      my (@fa) = join(" ", splice(@data, 2));
      $server->send_raw("privmsg $operservice :autokill time $data");
    }
  } else {
    Irssi::active_win()->print("*** Usage: /akill [time in minutes] <userid\@host.ip|host.domain> [Reason]");
  }
}
Irssi::command_bind('ams', 'cmd_ams');
sub cmd_ams {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $amstime $data $amsmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /ams <userid\@host.ip>");
  }
}
Irssi::command_bind('amw', 'cmd_amw');
sub cmd_amw {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $amwtime $data $amwmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /amw <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('anc', 'cmd_anc');
sub cmd_anc {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $anctime $data $ancmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /anc <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('aps', 'cmd_aps');
sub cmd_aps {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $apstime $data $apsmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /aps <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('asa', 'cmd_asa');
sub cmd_asa {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $asatime $data $asamsg");
  } else {
    Irssi::active_win()->print("*** Usage: /asa <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('asi', 'cmd_asi');
sub cmd_asi {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $asitime $data $asimsg");
  } else {
    Irssi::active_win()->print("*** Usage: /asi <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('ats', 'cmd_ats');
sub cmd_ats {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $atstime $data $atsmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /ats <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('atssp', 'cmd_atssp');
sub cmd_atssp {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $operservice :autokill time $atssptime $data $atsspmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /atssp <userid\@host.ip|host.domain>");
  }
}
Irssi::command_bind('chatops', 'cmd_chatops');
sub cmd_chatops {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("chatops :$data");
  } else {
    Irssi::active_win()->print("ChatOps: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('clonescan', 'cmd_clonescan');
sub cmd_clonescan {
  my ($data, $server, $channel) = @_;
  my ($cloneident) = '*';
  my ($cloneadd) = '*';
  if (!$data) {
    $data = $cloneaddress;
  }
  my (@cloneaddress) = split(/@/, $data);
  if ( $cloneaddress[1]) {
    $cloneident = '*'.$cloneaddress[0];
    $cloneadd = $cloneaddress[1];
  } else {
    $cloneident = '*';
    $cloneadd = $cloneaddress[0];
  }
  $server->send_raw("who +Cuh $cloneident $cloneadd");
}
Irssi::command_bind('clonescan2', 'cmd_clonescan2');
sub cmd_clonescan2 {
  my ($data, $server, $channel) = @_;
  my ($cloneident) = '*';
  my ($cloneadd) = '*';
  if (!$data) {
    $data = $cloneaddress2;
  }
  my (@cloneaddress) = split(/@/, $data);
  if ( $cloneaddress[1]) {
    $cloneident = '*'.$cloneaddress[0];
    $cloneadd = $cloneaddress[1];
  } else {
    $cloneident = '*';
    $cloneadd = $cloneaddress[0];
  }
  $server->send_raw("who +Cui $cloneident $cloneadd");
}

Irssi::command_bind('globops', 'cmd_globops');
sub cmd_globops {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("globops :$data");
  } else {
    Irssi::active_win()->print("GlobOps: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('helpserv', 'cmd_helpserv');
sub cmd_helpserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg helpserv :$data");
  } else {
    Irssi::active_win()->print("HelpServ: No data to send");
  }
}
Irssi::command_bind('kfl', 'cmd_kfl');
sub cmd_kfl {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$kflmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /kfl <nick>");
  }
}
Irssi::command_bind('kflsp', 'cmd_kflsp');
sub cmd_kflsp {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$kflspmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /kflsp <nick>");
  }
}
Irssi::command_bind('kh', 'cmd_kh');
sub cmd_kh {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$khmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /kh <nick>");
  }
}
Irssi::command_bind('khsp', 'cmd_khsp');
sub cmd_khsp {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$khspmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /khsp <nick>");
  }
}
Irssi::command_bind('kline', 'cmd_kline');
sub cmd_kline {
  my ($data, $server, $channel) = @_;
  my (@data) = split(/ /, $data);
  if ($data) {
    if ( $data[0] =~ /\./) {
      my (@fa) = join(" ", splice(@data, 1));
      $server->send_raw("kline $data[0] :@fa");
    } else {
      my (@fa) = join(" ", splice(@data, 2));
      $server->send_raw("kline $data[0] $data[1] :@fa");
    }
  } else {
    Irssi::active_win()->print("*** Usage: /kline [time in minutes] <userid\@host.ip|host.domain> [Reason]");
  }
}
Irssi::command_bind('km', 'cmd_km');
sub cmd_km {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$kmmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /km <nick>");
  }
}
Irssi::command_bind('kmsp', 'cmd_kmsp');
sub cmd_kmsp {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("kill $data :$kmspmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /kmsp <nick>");
  }
}
Irssi::command_bind('locops', 'cmd_locops');
sub cmd_locops {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("locops :$data");
  } else {
    Irssi::active_win()->print("LocOps: Command not given, we can\'t send an empty request");
  }
}
Irssi::command_bind('mass', 'cmd_mass');
sub cmd_mass {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("who $data");
  } else {
    Irssi::active_win()->print("*** Usage: /mass <flags, mask, etc>");
  }
}
Irssi::command_bind('massr', 'cmd_massr');
sub cmd_massr {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("rwho $data");
  } else {
    Irssi::active_win()->print("*** Usage: /massr <flags, mask, etc>");
  }
}
Irssi::command_bind('rootserv', 'cmd_rootserv');
sub cmd_rootserv {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("RootServ $data");
  } else {
    Irssi::active_win()->print("RootServ: No data to send");
  }
}
Irssi::command_bind('sajoin', 'cmd_sajoin');
sub cmd_sajoin {
  my ($data, $server, $witem) = @_;
  if ($data) {
    $server->send_raw("sajoin $data");
  } else {
    Irssi::active_win()->print("SAjoin: Please send channel name");
  }
}
Irssi::command_bind('saopme', 'cmd_saopme');
sub cmd_saopme {
  my ($data, $server, $witem) = @_;
  $witem->command("samode ".$witem->{name}." +o ".$server->{nick});
}
Irssi::command_bind('setos', 'cmd_setos');
sub cmd_setos {
  my ($data, $server, $witem) = @_;
  if ($data) {
    $operservice = $data;
    Irssi::active_win()->print("Setting OperService to: $operservice");
  } else {
    Irssi::active_win()->print("Current OperService: $operservice");
  }
}
Irssi::command_bind('snotice', 'cmd_snotice');
sub cmd_snotice {
  my ($data, $server, $channel) = @_;
  my (@data) = split(/ /, $data);
  my (@fa) = join(" ", splice(@data, 1));
  if (@fa) {
    $server->send_raw("notice \$$data[0] :[Server Notice] @fa [Please do NOT respond]");
  } else {
    Irssi::active_win()->print("*** Usage: /snotice SERVER MSG");
  }
}
# Server Ping
# /SPING [server] - checks latency between current server and [server]
Irssi::signal_add("event pong", "event_pong");
Irssi::command_bind("sping", "cmd_sping");

my %askping;

sub cmd_sping {
        my ($target, $server, $winit) = @_;

        $target = $server->{address} unless $target;
        $askping{$target} = time();
        $server->send_raw("PING $server->{address} $target");
}

sub event_pong {
        my ($server, $args, $sname) = @_;

        Irssi::signal_stop() if ($askping{$sname});

        Irssi::print(">> $sname latency: " . (time() - $askping{$sname}) . "s");
        undef $askping{$sname};
}
Irssi::command_bind('wm', 'cmd_wm');
sub cmd_wm {
  my ($data, $server, $channel) = @_;
  if ($data) {
    $server->send_raw("privmsg $data :$wmmsg");
  } else {
    Irssi::active_win()->print("*** Usage: /wm <nick>");
  }
}
#
# Special key bindings
#
Irssi::command("^BIND meta-c /clonescan");
Irssi::command("^BIND meta-l /clonescan2");

