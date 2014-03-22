#!/bin/bash

# setup container specific config
sed "s|GEARMAN_MASTER|$GM_PORT_4730_TCP_ADDR:$GM_PORT_4730_TCP_PORT|g" behat-client.yml.tpl > behat-client.yml

bin/behat --config behat-client.yml



