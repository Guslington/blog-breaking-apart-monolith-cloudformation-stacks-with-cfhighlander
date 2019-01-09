#!/bin/bash

if [ ! -z ${SSM_PATH+x} ]; then
  awsenv
  source /ssm/.env
fi

exec $@
