# AutoSlackStatus (ASS)

Auto Slack Status or ASS for short, is a script which sets your slack status acording to the WiFi SSID you are connected to.

## Installation

Clone the repository and a cronjob to run it!

```bash
git clone git@github.com:martin-bucinskas/autoslackstatus.git ~/autoslackstatus
chmod +x ~/autoslackstatus/slack-status.sh
crontab -e
```
Add this entry to cron to run every 30 minutes. Simple!
```
30 * * * * cd ~/autoslackstatus & ./slack-status.sh
```

## Configuration
To set up your newly installed ASS, you'll need your slack token and fill out the statuses.
```bash
SLACK_TOKEN=""
# Default status if no SSID matches
STATUS=""
EMOJI=""

STATUSES=("Home Lab;WFH;:house:"
          "Engine-Internal;At GPS;:office:"
          "iPhone;Working Remotely;:wave:"
          "GreenMan;At the pub;:beer:")
```

You can leave the default status and emoji blank or set to something else, this will only be set if no WiFi SSID is matched.

The syntax for setting your status follows this:
```bash
WIFI_SSID;STATUS;EMOJI
```
Do not forget the colons in the emoji part!

## License
[MIT](https://choosealicense.com/licenses/mit/)
