# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'resque/tasks'
require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
task 'resque:setup' => :environment

# desc "Custom Startup Routine"
# task :task_name => [:dependent, :tasks] do
#     RedisRunner.start
#
# end
#
# desc "Custom Shutdown Routine"
# task :task_name => [:dependent, :tasks] do
#     RedisRunner.stop
# end
