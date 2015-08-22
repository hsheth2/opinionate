#!/usr/bin/env sh

ps aux | grep -e foreman -e rails -e rake | grep -v grep
