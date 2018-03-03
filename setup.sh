#!/bin/bash

ruby db_init.rb $1 $2
rvm cron setup # set env varibles for cron
whenever --update-crontab # update cron with appropriate tasks for app 
crontab -l
