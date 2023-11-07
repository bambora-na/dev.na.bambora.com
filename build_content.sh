#!/bin/bash
set -e

# This script is used by Bamboo to generate the dev portal doc content.  The
# BRANCH and APP_HOME variables are passed in as env vars by Bamboo.

echo "BRANCH is $BRANCH yo"
echo "APP_HOME is $APP_HOME yo"

if [ "$BRANCH" = "careless-whisper" ]
then
    ONBOARDING_HOST='dev-onboardingapi'
elif [ "$BRANCH" = "billing-and-transfer" ]
then
    ONBOARDING_HOST='dev-onboardingapi'
elif [ "$BRANCH" = "careless-whisper-rebrand" ]
then
    ONBOARDING_HOST='dev-onboardingapi'
elif [ "$BRANCH" = "staging" ]
then
    ONBOARDING_HOST='test-onboardingapi'
elif [ "$BRANCH" = "test" ]
then
    ONBOARDING_HOST='test-onboardingapi'
else
    ONBOARDING_HOST='onboardingapi'
fi

ls $APP_HOME/source/*
#echo $APP_HOME


echo "ONBOARDING_HOST is $ONBOARDING_HOST"
mkdir -p build
docker run -e ONBOARDING_HOST=${ONBOARDING_HOST} -v $APP_HOME/build:/usr/src/app/build dev.bambora.com static


