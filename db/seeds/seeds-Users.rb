####################################
#          Seed A User
####################################
User.create(admin: 1, email: 'test@test.com', password: 'topsecret', password_confirmation: 'topsecret');


####################################
#          Seed the Operators
####################################

Operator.create( name: 'equals',        sql_value: '=',       html_representation: '=')
Operator.create( name: 'like',          sql_value: ' like ',  html_representation: 'has a')
Operator.create( name: 'greaterthan',   sql_value: '>',       html_representation: '&gt;')
Operator.create( name: 'lessthan',      sql_value: '<',       html_representation: '&lt;')
Operator.create( name: 'doesnotequal',  sql_value: '<>',      html_representation: '&ne;')


####################################
#          Seed the Datatypes
####################################

Datatype.create( name: 'text')
Datatype.create( name: 'number')
Datatype.create( name: 'yes/no')
Datatype.create( name: 'date')