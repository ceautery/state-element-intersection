#!/bin/zsh

wt() {
  print "\n$1"
  read -s -k '?...'
  printf "\r   \r"
}

clear
print 'Show the intersection between periodic table symbols and US state abbreviations'

wt 'Sample element'
jq '.elements[0] | del(.image)' elements.json

wt 'Two digit element symbols'
local ELEMENTS=($(jq -r '.elements[].symbol' elements.json | awk 'length($0) == 2 { print toupper($0) }'))
print $ELEMENTS

wt 'Sample state'
jq '.states[0]' states.json

wt 'State abbreviations'
local STATES=($(jq -r '.states[].abbreviation' states.json))
print $STATES

wt 'Intersection'
print "${(@)STATES:*ELEMENTS}"
