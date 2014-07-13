####################################
#          Seed A User
####################################
User.create(admin: 1, visual_interface: 0, email: 'test@test.com', password: 'topsecret', password_confirmation: 'topsecret');


####################################
#          Seed the Operators
####################################

Operator.create( name: 'equals',        sql_value: ' = ',		html_representation: '=')
Operator.create( name: 'like',          sql_value: ' like ',	html_representation: 'contains')
Operator.create( name: 'greaterthan',   sql_value: ' > ',		html_representation: '&gt;')
Operator.create( name: 'lessthan',      sql_value: ' < ',		html_representation: '&lt;')
Operator.create( name: 'doesnotequal',  sql_value: ' != ',		html_representation: '&ne;')