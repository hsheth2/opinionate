#!/usr/bin/env bash

#rake db:schema:load
spring stop
rake db:drop db:create db:migrate
bin/rails runner GoogleTrends.perform
bin/rails runner PullTrends.perform
