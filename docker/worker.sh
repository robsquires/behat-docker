#!/bin/bash

# setup container specific config
sed "s|GEARMAN_MASTER|$GM_PORT_4730_TCP_ADDR:$GM_PORT_4730_TCP_PORT|g" behat-worker.yml.tpl > behat-worker.yml

bin/behat --config behat-worker.yml
