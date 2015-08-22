#!/usr/bin/env bash

ps aux | grep -e foreman -e rails -e rake | grep -v grep | tr -s " " | cut -d " " -f 2 | xargs kill
