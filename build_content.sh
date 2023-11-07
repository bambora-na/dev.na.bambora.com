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

echo "Start echoing--"

ls $APP_HOME/*
#echo $APP_HOME

echo "Start source--"
cat $APP_HOME/version.json

sed -i 's|BRANCH|'$BRANCH'|g' $APP_HOME/version.json
sed -i 's|REVISION|'$REVISION'|g' $APP_HOME/version.json
sed -i 's|BUILD_TIME|'$BUILD_TIME'|g' $APP_HOME/version.json
sed -i 's|BUILD_NUMBER|'$BUILD_NUMBER'|g' $APP_HOME/version.json

cp $APP_HOME/version.json $APP_HOME/source/version.json


cat $APP_HOME/source/version.json

echo "End source--"

echo "Start build--"
cat $APP_HOME/build/version.json
sed -i 's|BRANCH|'$BRANCH'|g' $APP_HOME/build/version.json
sed -i 's|REVISION|'$REVISION'|g' $APP_HOME/build/version.json
sed -i 's|BUILD_TIME|'$BUILD_TIME'|g' $APP_HOME/build/version.json
sed -i 's|BUILD_NUMBER|'$BUILD_NUMBER'|g' $APP_HOME/build/version.json

cat $APP_HOME/build/version.json
echo "Start build--"

#BRANCH="${bamboo.shortPlanName}" APP_HOME=${bamboo.build.working.directory} BUILD_NUMBER=${bamboo.buildNumber} BUILD_TIME=${bamboo.buildTimeStamp} REVISION=${bamboo.planRepository.revision}

#docker build -t devbamboracom

echo "ONBOARDING_HOST is $ONBOARDING_HOST"
mkdir -p build
docker run -e ONBOARDING_HOST=${ONBOARDING_HOST} -v $APP_HOME/build:/usr/src/app/build dev.bambora.com static

#docker exec ${ONBOARDING_HOST} sed -i 's|BRANCH|XXXXXX|g' /usr/src/app/build/version.json

