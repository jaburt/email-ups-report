#!/bin/sh

## Notes ##
## You can heavily personalize the attributes depending on your particular UPS, use:
## upsc your_ups_name@localhost to see all the 
## attributes and pick the ones you want

### Parameters ###
logfile="/tmp/ups_report.tmp"
email="YOUR_EMAIL_ADDRESS"
subject="UPS Status Report for FreeNAS"
ups="YOUR_UPS_NAME@localhost"

### Set email headers ###
(
    echo "To: ${email}"
    echo "Subject: ${subject}"
    echo "Content-Type: text/html"
    echo "MIME-Version: 1.0"
    echo -e "\r\n" 
) > ${logfile}

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
) >> ${logfile}

### Send report ###
sendmail -t < ${logfile}
rm ${logfile}

### End ###
