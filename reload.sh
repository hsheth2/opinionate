#!/usr/bin/env bash

. ./env.sh

#rake db:schema:load
bin/spring stop
bin/rake db:drop db:create db:migrate
bin/rails runner GoogleTrends.perform
bin/rails runner PullTrends.perform
