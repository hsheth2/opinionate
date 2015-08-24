#!/usr/bin/env bash

#rake db:schema:load
rake db:drop db:create db:migrate
bin/rails runner GoogleTrends.perform
bin/rails runner PullTrends.perform
