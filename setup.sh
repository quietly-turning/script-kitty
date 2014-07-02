#!/bin/bash



# devise stuff
rails g devise:install
rails g devise user
rails g migration AddAdminToUsers admin:boolean
rails g migration AddVisualInterfaceToUsers visual_interface:boolean

# dataset stuff
rails g scaffold control name description:text
rails g scaffold level description:text
rails g scaffold locale name description
rails g scaffold institution name city state zip chief control:references level:references locale:references
rails g scaffold website classification url institution:references

# query building stuff
rails g scaffold datatype name
rails g scaffold exercise question:text
rails g scaffold query dummy_id:integer formatted_sql:text raw_sql:text html_table:text user:references exercise:references
rails g scaffold operator name sql_value html_representation query:references
rails g scaffold condition column parameter operator:references query:references complexOperator

# rake tasks
rake db:migrate
rake db:seed


# misc. notes
# need to create a DB user with limited permissions (insert, select):  thesis_user

# GRANT SELECT ON thesis.* TO 'thesis-user'@'localhost' IDENTIFIED BY 'moomoo';
# GRANT INSERT ON thesis.queries TO 'thesis-user'@'localhost' IDENTIFIED BY 'moomoo';
# GRANT INSERT ON thesis.conditions TO 'thesis-user'@'localhost' IDENTIFIED BY 'moomoo';
# GRANT INSERT ON thesis.users TO 'thesis-user'@'localhost' IDENTIFIED BY 'moomoo';