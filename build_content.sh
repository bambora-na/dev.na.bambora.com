#!/bin/bash
set -e

# This script is used by Bamboo to generate the dev portal doc content.  The
# BRANCH and APP_HOME variables are passed in as env vars by Bamboo.

echo "BRANCH is $BRANCH yo"
echo "APP_HOME is $APP_HOME yo"

#FILE_VERSION_PATH = $APP_HOME/source/version.json

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


echo "ONBOARDING_HOST is $ONBOARDING_HOST"
mkdir -p build
docker run -e ONBOARDING_HOST=${ONBOARDING_HOST} -v $APP_HOME/build:/usr/src/app/build dev.bambora.com static

#docker exec ${ONBOARDING_HOST} sed -i 's|BRANCH|XXXXXX|g' /usr/src/app/build/version.json

