#!/usr/bin/env bash
#
#  Copyright ©2018 efikarl, https://efikarl.com.
#
#  This program is just made available under the terms and conditions of the
#  MIT license: https://efikarl.com/mit-license.html.
#
#  THE PROGRAM IS DISTRIBUTED UNDER THE MIT LICENSE ON AN "AS IS" BASIS,
#  WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
#
#--

ekvc_font()
{
  echo "ekvc_font ..."
  if [[ `uname` == 'Darwin' ]]
  then #macos
    fontdir="$HOME/Library/Fonts"
  else #linux
    fontdir="$HOME/.local/share/fonts"
  fi
  [[ -d $fontdir ]] || mkdir -p $fontdir
  cp -f $ekvcdir/fonts/Hack/*   $fontdir
  echo "ekvc_font done"
}

ekvc_requisite()
{
  echo "ekvc_requisite ..."

  prerequisite="nvim git curl python${pythonr}"
  meet=1
  for i in $prerequisite
  do
    hash $i &> /dev/null || {
      meet=0
      echo "command is not found, please install: $i!"
    }
  done
  [[ $meet == 0 ]] && {
    exit 1
  }
  # install defx depex
  if ! (hash pip${pythonr}) &> /dev/null
  then
    curl https://bootstrap.pypa.io/get-pip.py | python${pythonr} > /dev/null
  fi
  python${pythonr} -m pip install --user pynvim > /dev/null

  echo "ekvc_requisite done"
}

ekvc_install()
{
  echo "ekvc_install ..."
  # clone or update ekvc
  [[ ! -d $ekvcdir ]] && {
    git clone https://github.com/efikarl/ekvc.git $ekvcdir
  } || {
    [[ -d $ekvcdir/.git ]] && {
      git -C $ekvcdir fetch --all
      git -C $ekvcdir reset --hard origin/master
    }
  }

  # install font for ekvc
  ekvc_font

  # setup soft link to nvim configuration
  ([[ -d $initdir ]] || mkdir -p $initdir) && ([[ -d $initdir/nvim ]] && rm -rf $initdir/nvim)
  ln -sfnv $ekvcdir $initdir/nvim

  # install vim-plug for plugins management
  nvim +PlugUpdate +qall
  echo "ekvc_install done"
}

ekvc_remove()
{
  # delete soft link
  [[ -h $initdir ]] && rm $initdir
  # delete ekvc home
  [[ -d $ekvcdir ]] && rm -rf $ekvcdir
  echo -e "Let it go, \033[31m:-(\033[0m"
}

ekvc_help()
{
  echo
  echo "ekvc.sh:"
  echo "  ./ekvc.sh [-i] [-r]"
  echo "parameters:"
  echo "  -i        Install ekvc."
  echo "  -r        Remove/Uninstall ekvc."
  echo
  exit -1
}

insflag=1
ekvcdir=~/.ekvc
initdir=~/.config
pythonr=3

while getopts 'ri' opt
do
  case $opt in
  r) insflag=0;;
  i) insflag=1;;
  *) ekvc_help;;
  esac
done

if [[ $insflag == 0 ]]
then
  ekvc_remove
else
  ekvc_requisite
  ekvc_install
  echo
  echo -e "[\033[36mE\033[0m]fi[\033[5;32mK\033[0m]arl's [\033[36mV\033[0m]im [\033[36mC\033[0m]onfiguration is ok! \033[32mEnjoy :-)\033[0m"
  echo
fi
