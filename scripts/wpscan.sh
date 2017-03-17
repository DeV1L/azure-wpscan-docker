#!/bin/bash
# Script for scan WordPress vulnerabilities 
LOG_TIME=` date +"%b %e %Y %T"`
WPSACAN_LOG="/tmp/wpscan_$1.log"

smtpemailfrom="wpscan@arkadium.com"
mailto="$2"
subject="WPScan report for $1"    
EML="/tmp/wpscan.eml"

sudo docker run --rm wpscanteam/wpscan ruby wpscan.rb --update
sudo docker run --rm wpscanteam/wpscan ruby wpscan.rb --url $1 > $WPSACAN_LOG

echo "From: \"WPScan\"<$smtpemailfrom>" > $EML
echo "To: $mailto" >> $EML
echo "Subject: $subject" >> $EML
echo "" >> $EML
cat $WPSACAN_LOG >> $EML

/usr/sbin/ssmtp ${mailto} < $EML

/bin/rm $EML



