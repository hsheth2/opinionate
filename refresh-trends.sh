#!/usr/bin/env bash

. ./env.sh

#rake db:schema:load
bin/spring stop
bin/rake db:drop db:create db:schema:load
bin/rails runner GoogleTrends.perform
bin/rails runner PullTrends.perform
