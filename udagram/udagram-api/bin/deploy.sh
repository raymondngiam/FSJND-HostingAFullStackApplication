#!/bin/bash

script_path=$(cd "$(dirname "$0")"; pwd)
echo "script path: $script_path"
cd $script_path/..
echo "eb root path: $(pwd)"
eb init --region us-east-1 --platform node.js-14 
eb create udagram-api-dev --single \
    --cname udagram-api-dev-78685 \
    --keyname udagram-test-keypair \
    --instance-types t2.medium
eb list
eb use udagram-api-dev
eb setenv POSTGRES_USERNAME=$POSTGRES_USERNAME \
    POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
    POSTGRES_HOST=$POSTGRES_HOST \
    POSTGRES_DB=$POSTGRES_DB \
    AWS_BUCKET=$AWS_BUCKET \
    AWS_REGION=$AWS_REGION \
    AWS_PROFILE=$AWS_PROFILE \
    JWT_SECRET=$JWT_SECRET
eb deploy
