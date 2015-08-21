#!/bin/bash

if [ -z "$WERCKER_ROLLBAR_NOTIFY_ACCESS_TOKEN" ]; then
  fail 'Please specify access-token property'
fi

if [ -z "$WERCKER_ROLLBAR_NOTIFY_ON" ]; then
  WERCKER_ROLLBAR_NOTIFY_ON="passed"
fi

if [ -n "$WERCKER_ROLLBAR_NOTIFY_BRANCH" && "$WERCKER_ROLLBAR_NOTIFY_BRANCH" -ne "$WERCKER_GIT_BRANCH" ]; then
    info "Not building for branch $WERCKER_GIT_BRANCH"
    return 0
fi

if [ "$WERCKER_ROLLBAR_NOTIFY_ON" = "passed" ]; then
  if [ "$WERCKER_RESULT" = "failed" ]; then
    info "Skipping..."
    return 0
  fi
fi

curl https://api.rollbar.com/api/1/deploy/ \
  -F access_token="$WERCKER_ROLLBAR_NOTIFY_ACCESS_TOKEN" \
  -F environment="${WERCKER_ROLLBAR_NOTIFY_ENVIRONMENT:-$WERCKER_DEPLOYTARGET_NAME}" \
  -F revision="$WERCKER_GIT_COMMIT" \
  -F local_username="${WERCKER_ROLLBAR_NOTIFY_USERNAME:-$WERCKER_STARTED_BY}"
