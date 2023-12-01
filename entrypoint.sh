#!/bin/bash
 
set -e
 
export SECRET_KEY_BASE=$(rake secret)
rake db:create
rake db:migrate
rake assets:precompile
 
exec "$@"
