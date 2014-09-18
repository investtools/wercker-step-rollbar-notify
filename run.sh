#!/bin/bash

if [ ! -n "$WERCKER_ROLLBAR_NOTIFY_ACCESS_TOKEN" ]; then
  error 'Please specify access-token property'
  exit 1
fi

if [ "$WERCKER_ROLLBAR_NOTIFY_ON" = "passed" ]; then
  if [ "$WERCKER_RESULT" = "failed" ]; then
    echo "Skipping.."
    return 0
  fi
fi
curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token=$WERCKER_ROLLBAR_NOTIFY_ACCESS_TOKEN \
  -F environment=${WERCKER_ROLLBAR_NOTIFY_ENVIRONMENT:-$WERCKER_DEPLOYTARGET_NAME} \
  -F revision=$WERCKER_GIT_COMMIT \
  -F local_username=${WERCKER_ROLLBAR_NOTIFY_USERNAME:-$WERCKER_STARTED_BY}