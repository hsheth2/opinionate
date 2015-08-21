#!/usr/bin/env bash

rake db:schema:load
bin/rails runner GoogleTrends.perform; bin/rails runner PullTrends.perform
