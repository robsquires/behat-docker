#!/bin/bash

red="$(tput setaf 1)"
yel="$(tput setaf 3)"
blue="$(tput setaf 4)"
white="$(tput setaf 7)"

reset="$(tput sgr0)"
echo -e "${yel}  Behat ${white} + ${red} Gearman ${white} + ${blue} Docker ${reset}"


#
# configure docker link variables
# 


gearman_addr="GM_PORT_4730_TCP_ADDR"
gearman_port="GM_PORT_4730_TCP_PORT"

export BEHAT_PARAMS="extensions[VIPSoft\GearmanExtension\Extension][gearman_server]=${!gearman_addr}:${!gearman_port}"

# test="echo 'rob'"
${1}

exit $?