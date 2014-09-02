#!/bin/sh

# CCE-4388-5
chmod 600 /etc/crontab
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly
chmod 700 /etc/cron.d

