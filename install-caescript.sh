#!/bin/sh
echo ---
echo This script will install 'CaeScript' for irssi
echo ---
echo Do you want to continue? [Y/N]
read continue
if [ $continue = "Y" ] || [ $continue = "y" ]; then
  echo '---'
  echo . Creating directories
  mkdir -pv ~/.irssi/scripts/autorun/
  echo . Installing CaeScript
  cp caescript.pl ~/.irssi/scripts/.
  cp ircoptools.pl ~/.irssi/scripts/.
  echo '---'
  echo Do you want to download other irssi suggested scripts? [Y/N]
  read additional
  if [ $additional = "Y" ] || [ $additional = "y" ]; then
    echo '---'
    echo . Downloading additional irssi scripts
    wget -q http://scripts.irssi.org/scripts/chops.pl -O ~/.irssi/scripts/chops.pl
    wget -q http://scripts.irssi.org/scripts/dispatch.pl -O ~/.irssi/scripts/dispatch.pl
    wget -q http://scripts.irssi.org/scripts/dns.pl -O ~/.irssi/scripts/dns.pl
    wget -q http://scripts.irssi.org/scripts/go.pl -O ~/.irssi/scripts/go.pl
    wget -q http://scripts.irssi.org/scripts/mkick.pl -O ~/.irssi/scripts/mkick.pl
    wget -q http://scripts.irssi.org/scripts/nicklist.pl -O ~/.irssi/scripts/nicklist.pl
    wget -q http://scripts.irssi.org/scripts/screen_away.pl -O ~/.irssi/scripts/screen_away.pl
    wget -q http://scripts.irssi.org/scripts/trackbar.pl -O ~/.irssi/scripts/trackbar.pl
    wget -q http://scripts.irssi.org/scripts/usercount.pl -O ~/.irssi/scripts/usercount.pl
    wget -q http://scripts.irssi.org/scripts/users.pl -O ~/.irssi/scripts/users.pl
    wget -q http://scripts.irssi.org/scripts/whois.pl -O ~/.irssi/scripts/whois.pl
  fi
  echo '---'
  echo Do you want to autorun the scripts? [Y/N]
  read autorun
  if [ $autorun  = "Y" ] || [ $autorun = "y" ]; then
    echo '---'
    echo Configuring autorun
    ln -fs ~/.irssi/scripts/caescript.pl ~/.irssi/scripts/autorun/caescript.pl  
    if [ $additional = "Y" ] || [ $additional = "y" ]; then
      ln -fs ~/.irssi/scripts/chops.pl ~/.irssi/scripts/autorun/chops.pl
      ln -fs ~/.irssi/scripts/dispatch.pl ~/.irssi/scripts/autorun/dispatch.pl
      ln -fs ~/.irssi/scripts/dns.pl ~/.irssi/scripts/autorun/dns.pl
      ln -fs ~/.irssi/scripts/go.pl ~/.irssi/scripts/autorun/go.pl
      ln -fs ~/.irssi/scripts/mkick.pl ~/.irssi/scripts/autorun/mkick.pl
      ln -fs ~/.irssi/scripts/nicklist.pl ~/.irssi/scripts/autorun/nicklist.pl
      ln -fs ~/.irssi/scripts/screen_away.pl ~/.irssi/scripts/autorun/screen_away.pl
      ln -fs ~/.irssi/scripts/trackbar.pl ~/.irssi/scripts/autorun/trackbar.pl
      ln -fs ~/.irssi/scripts/usercount.pl ~/.irssi/scripts/autorun/usercount.pl
      ln -fs ~/.irssi/scripts/users.pl ~/.irssi/scripts/autorun/users.pl
      ln -fs ~/.irssi/scripts/whois.pl ~/.irssi/scripts/autorun/whois.pl
    fi
  else
    echo Please don\'t forget to run caescript.pl once you started irssi 
  fi
  echo '---'
  echo Installation finished, feel free to run irssi
fi
