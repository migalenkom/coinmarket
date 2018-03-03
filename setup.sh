#!/bin/bash

ruby db_init.rb $1 $2
#rvm cron setup
#whenever --update-crontab
crontab -l
