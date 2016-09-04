#!/usr/bin/env sh

. ./env.sh
foreman start -c resque=4,web=1 > foreman.logs 2>&1 &
