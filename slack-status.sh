#!/bin/bash

SLACK_TOKEN=""

# Default status if no SSID matches
STATUS=""
EMOJI=""

STATUSES=("Home Lab;WFH;:house:"
          "Engine-Internal;At GPS;:office:"
          "iPhone;Working Remotely;:wave:"
          "GreenMan;At the pub;:beer:")

WIFI_SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}')

for slack_status in "${STATUSES[@]}" ; do
  KEY="${slack_status%%;*}"
  
  if [[ "$WIFI_SSID" == *"$KEY"* ]]; then
    IFS=';'
    read -ra UNPACKED <<< "$slack_status"
    STATUS=${UNPACKED[1]}
    EMOJI=${UNPACKED[2]}
    IFS=' '
  fi
done

PAYLOAD=$(cat <<EOF
{
  "profile": {
    "status_text": "$STATUS",
    "status_emoji": "$EMOJI",
    "status_expiration": 0
  }
}
EOF
)

curl -X POST -H "Authorization: Bearer $SLACK_TOKEN" \
  -H "Content-type: application/json" \
  --data "$PAYLOAD" \
  https://one-engine.slack.com/api/users.profile.set

