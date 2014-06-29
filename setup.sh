#!/bin/bash



# devise stuff
rails g devise:install
rails g devise user
rails g migration AddAdminToUsers admin:boolean

# dataset stuff
rails g scaffold control name description:text
rails g scaffold level description:text
rails g scaffold locale name description
rails g scaffold institution name city state zip chief control:references level:references locale:references
rails g scaffold website classification url institution:references

# query building stuff
rails g scaffold datatype name
rails g scaffold operator name sql_value html_representation
rails g scaffold query name dummy_id:integer formatted_sql:text raw_sql:text html_table:text user:references
rails g scaffold condition column parameter operator:references query:references complexOperator

# rake tasks
rake db:migrate
rake db:seed