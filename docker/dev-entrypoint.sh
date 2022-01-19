#!/bin/bash

rm -f /blog-rails/tmp/pids/server.pid
exec "$@"
