# Rake::Task["db:seed"].clear
#
# schemas = ["learner", "admin"]
#
# namespace :db do
#
# 	task :seed => [:environment, :load_config] do
# 		schemas.each do |schema|
# 			Dir[File.join(Rails.root, 'db', 'seeds', "#{schema}", '*.rb')].sort.each do |filename|
# 				puts "loading: #{filename}"
# 				load filename
# 			end
# 		end
# 	end
# end