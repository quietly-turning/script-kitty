# # see: http://excid3.com/blog/rails-activerecord-multiple-databases-and-migrations/
#
# Rake::Task["db:migrate"].clear
# Rake::Task["db:schema:dump"].clear
# Rake::Task["db:schema:load"].clear
#
# schemas = ["", "_learner"]
#
# namespace :db do
# 	task :migrate do
# 		schemas.each do |schema|
# 			ActiveRecord::Base.establish_connection YAML::load(File.open(File.join("#{Rails.root}",'config','database.yml')))["#{Rails.env}#{schema}"]
# 			ActiveRecord::Migrator.migrate("db/migrate/#{schema}/")
# 		end
# 	end
#
# 	namespace :schema do
# 		task :dump => [:load_config]  do
# 			schemas.each do |schema|
# 				File.open("#{Rails.root}/db/schema#{schema}.rb", 'w:utf-8') do |file|
# 					ActiveRecord::Base.establish_connection("#{Rails.env}#{schema}".intern)
# 					ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
# 				end
# 			end
# 	  	end
#
# 		task :load => [:load_config] do
# 	        schemas.each do |schema|
# 				ActiveRecord::Schema.verbose = false
#
# 				ActiveRecord::Base.establish_connection("#{Rails.env}#{schema}".intern)
# 	       	 	load("#{Rails.root}/db/schema#{schema}.rb")
# 			end
# 		end
#
# 		task :status => [:load_config] do
# 			schemas.each do |schema|
# 				ActiveRecord::Base.establish_connection("#{Rails.env}#{schema}".intern)
#
# 				# man, what an ugly hack...
# 				if schema.empty?
# 					schema = "admin"
# 				elsif schema == "_learner"
# 					schema = "learner"
# 				end
#
# 				ActiveRecord::Migrator.migrations_paths = "#{Rails.root}/db/migrate/#{schema}"
#
# 				unless ActiveRecord::Base.connection.table_exists?(ActiveRecord::Migrator.schema_migrations_table_name)
# 					puts 'Schema migrations table does not exist yet.'
# 					next  # means "return" for rake task
# 				end
# 				db_list = ActiveRecord::Base.connection.select_values("SELECT version FROM #{ActiveRecord::Migrator.schema_migrations_table_name}")
# 				db_list.map! { |version| "%.3d" % version }
# 				file_list = []
# 				ActiveRecord::Migrator.migrations_paths.each do |path|
# 					Dir.foreach(path) do |file|
# 					  	# match "20091231235959_some_name.rb" and "001_some_name.rb" pattern
# 					  	if match_data = /^(\d{3,})_(.+)\.rb$/.match(file)
# 					    	status = db_list.delete(match_data[1]) ? 'up' : 'down'
# 					   		file_list << [status, match_data[1], match_data[2].humanize]
# 					  	end
# 					end
# 				end
#
# 				db_list.map! do |version|
# 					['up', version, '********** NO FILE **********']
# 				end
#
# 				# output
# 				puts "\ndatabase: #{ActiveRecord::Base.connection_config[:database]}\n\n"
# 				puts "#{'Status'.center(8)}  #{'Migration ID'.ljust(14)}  Migration Name"
# 				puts "-" * 50
#
# 				(db_list + file_list).sort_by {|migration| migration[1]}.each do |migration|
# 					puts "#{migration[0].center(8)}  #{migration[1].ljust(14)}  #{migration[2]}"
# 				end
# 				puts
# 			end
# 	    end
# 	end
# end