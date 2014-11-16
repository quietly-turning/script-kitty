#!/bin/bash



# devise stuff
rails g devise:install
rails g devise user
rails g migration AddAdminToUsers admin:boolean
rails g migration AddVisualInterfaceToUsers visual_interface:boolean

# dataset stuff
rails g scaffold website url:string classification:string school:references
rails g scaffold locale name:string description:string
rails g scaffold school name:string city:string state:string zip:string chief:string locale:references

# query building stuff
rails g scaffold datatype name
rails g scaffold exercise question:text answer:text response_correct:text response_incorrect:text lesson:references
rails g model    answer result_set_hash:string exercise:references
rails g scaffold query status:integer raw_sql:text html_table:text user:references exercise:references
rails g scaffold operator name sql_value html_representation query:references
rails g scaffold condition column parameter operator:references query:references complexOperator
rails g scaffold lesson title:text objective:text body:text

# rake tasks
rake db:migrate
rake db:seed


# misc. notes
# need to create a DB user (thesis_learner) with limited permissions (SELECT)

# GRANT SELECT ON ScriptKitty.schools TO 'thesis_learner'@'localhost' IDENTIFIED BY 'moomoo';
# GRANT SELECT ON ScriptKitty.locales TO 'thesis_learner'@'localhost' IDENTIFIED BY 'moomoo';
# GRANT SELECT ON ScriptKitty.websites TO 'thesis_learner'@'localhost' IDENTIFIED BY 'moomoo';