#!/bin/bash
#
# Roots Sage Requirements Module
# Author: Troy McGinnis
# Company: Gearbox
# Updated: March 10, 2018
#

roots-sage::requirements() {
  local requirements; requirements=(wp yarn composer)

  for i in "${requirements[@]}"; do
    cog::check_requirement "${i}"
  done
}