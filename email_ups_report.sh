#!/bin/sh

## Notes ##
## You can heavily personalize the attributes depending on your particular UPS, use: ## 
## upsc your_ups_name@localhost ## to see all the attributes and pick the ones you want ##

## emailing ##
# This script now uses "sendemail.py" as "sendmail" has been removed from TrueNAS Scale:
# Script can be downloaded from: https://github.com/oxyde1989/standalone-tn-send-email.
# Edit the "emailscript" with the location of the downloaded script (including script name).

### Parameters ###
logfile="/tmp/ups_report.tmp"
email="your@eaill.address"
subject="UPS Status Report for FreeNAS"
ups="APC_Smart-UPS_1500@localhost"
emailscript="/mnt/tank/scripts/sendemail.py"

### Set email body ###
(
    echo "<pre style=\"font-size:14px\">"
    echo "UPS report for: $(upsc ${ups} device.mfr) $(upsc ${ups} device.model) on $(upsc ${ups} driver.parameter.port)"
    echo ""
    date "+Time: %Y-%m-%d %H:%M:%S"
    echo ""
    echo "UPS Status: $(upsc ${ups} ups.status)"
    echo "Battery Runtime: $(upsc ${ups} battery.runtime) s"
    echo "Battery Charge: $(upsc ${ups} battery.charge) %"
    echo ""
    echo "*** Full extract of: upsc APC_Smart-UPS_1500@localhost"
    echo ""
    echo "$(upsc ${ups})"
    echo "</pre>" 
) > ${logfile}

### Send report ###
python3 "$emailscript" \
    --subject "$subject" \
    --to_address "$email" \
    --mail_body_html "$logfile" \

rm ${logfile}
