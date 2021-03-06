#!/bin/bash

#
#  private functions -----
#

#
#parse_yaml - parses a given yaml file to an (optional) prefix
#
function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}

         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

#
# remove_container - kills and removes a container
# 
function remove_container {
    local container_name=$1
    echo "--> Stopping container: $container_name"
    docker kill $container_name
    docker rm $container_name
}

#
# map_config - maps a node in the yaml config to a variable
# exits if node not found
# 
function map_config {
    node=$1
    mapTo=$2

    value=${!1}
    if [ -z "$value" ]
      then
        echo "Node '$node' not found"
        exit 1
    fi

    eval $(echo $mapTo=$value)
}


#
#  ----- end private functions 
#




#
# import the dockman config
#

dockmanFile='.dockman.yml'

if [ ! -f "$dockmanFile" ]; then
    echo "! Could not find $dockmanFile"
    exit 1
fi

eval $(parse_yaml $dockmanFile) 


#
# import the number of workers
#
pCount=$1;
: ${pCount:=1}


#
# import the container namespace
#
map_config 'namespace' 'cnt_namespace'



#
# Gearman container configuration
#
echo "-> CONFIGURING GEARMAN ......."

gearman_cnt_image='rgarcia/gearmand'
gearman_cnt_name=$cnt_namespace.gearman


docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)



#remove_container $gearman_cnt_name

echo "--> Starting container: $gearman_cnt_name"
docker run -d -name $gearman_cnt_name $gearman_cnt_image

#gearman link names

gearman_link_alias='GM'
gearman_link_port=4730
gearman_link_name=$gearman_cnt_name:$gearman_link_alias


#
# dockman-behat config
# 
base_cnt_cmd="./env.sh"


#
# Worker container configuration
#
echo "-> SETTING UP $pCount WORKER CONTAINERS......."

map_config 'worker_container__image' 'worker_cnt_image'

worker_cnt_prefix=$cnt_namespace.worker-
worker_cnt_cmd="$base_cnt_cmd behat-worker.yml"

#for  i in $(docker ps -a | grep -o "$worker_cnt_prefix[0-9]+(?!/)")
#  do
#    remove_container $i
#done


for (( i=1; i<=$pCount; i++ ))
do
    worker_cnt_name=$worker_cnt_prefix$i
    echo "--> Creating worker container: $worker_cnt_name"
    docker run -d --link $gearman_link_name  -name $worker_cnt_name $worker_cnt_image $worker_cnt_cmd
done


#
# Client container configuration
#
echo "-> SETTING UP CLIENT CONTAINER + RUNNING TESTS......."

map_config 'client_container__image' 'client_cnt_image'

client_cnt_name=$cnt_namespace.client
client_cnt_cmd="$base_cnt_cmd behat-client.yml"

#for  i in $(docker ps -a | grep -o "$client_cnt_name(?!/)")
#  do
#    remove_container $i
#done


echo "--> Creating client container: $client_cnt_name"
docker run -t -i -rm --link $gearman_link_name -name $client_cnt_name $client_cnt_image $client_cnt_cmd

