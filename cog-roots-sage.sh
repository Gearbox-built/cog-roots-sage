#!/bin/bash
#
# Cog Roots Sage Module
# Author: Troy McGinnis
# Company: Gearbox
# Updated: March 11, 2018
#
#
# HISTORY:
#
# * 2018-03-11 - v0.0.1 - First Creation
#
# ##################################################
#
if [[ ! "${#BASH_SOURCE[@]}" -gt 0 ]] || [[ "${BASH_SOURCE[${#BASH_SOURCE[@]}-1]##*/}" != 'cog.sh' ]]; then
  echo 'Module must be executed through cog.'
  return || exit
fi
#
cog::source_lib "${BASH_SOURCE[0]}"
#

# Roots Sage Install
# Downloads and installs a fresh WP instance
#
roots-sage::install() {
  message "Installing Roots Sage..."
  # 1. roots-sage::wp_install
  # 2. wp db create
  # 3. wp core install
}

# Roots Sage Setup
# Downloads, installs, and setups up a fresh WP instance
#
roots-sage::setup() {
  # $name,[$dir]
  cog::params "$@" --required="name" --optional="dir"

  message "Setting up Roots Sage..."
  # composer create-project "$ROOTS_COMPOSER_REPO" "$name" "$ROOTS_VERSION"
}

roots-sage::bootstrap() {
  message "Gearboxify."

  # wp::bootstrap "$@"? or wp::install "$@"?
  # roots-sage::setup "$@"
}


#
# Module main
# --------------------------------------------------

roots-sage::main() {
  roots-sage::requirements
  local module; module=$( basename "$( dirname "${BASH_SOURCE[0]}")")

  case "$1" in
    install)
      roots-sage::install "${@:2}"
      ;;
    setup)
      roots-sage::setup "${@:2}"
      ;;
    bootstrap)
      roots-sage::bootstrap "${@:2}"
      ;;
    *)
      local lib; lib="${module}::${1}::main"

      if [[ $(type -t "$lib") == 'function' ]]; then
        "$lib" "${@:2}"
        cog::exit
      else
        usage "cog roots-sage" "install,setup,bootstrap"
        cog::exit
      fi
      ;;
  esac
}