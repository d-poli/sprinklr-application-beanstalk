#!/bin/bash

environment="$1"
environment_prefix=$(echo $environment | head -c 1)
region="$2" 
application="sprinklr-application"   
docker_config="Dockerrun.aws.json"
beanstalk_config=".elasticbeanstalk/config.yml"
web_environment="${environment_prefix}-${application}"

sed \
    -e "s/WEB-ENVIRONMENT/$web_environment/g" \
    -e "s/REGION/$region/g" \
    $beanstalk_config.template | tee $beanstalk_config

sed \
    -e "s/TAG_VERSION/$CIRCLE_SHA1/g" \
    $docker_config.template | tee $docker_config

eb deploy  \
    $web_environment \
    -l $CIRCLE_SHA1

