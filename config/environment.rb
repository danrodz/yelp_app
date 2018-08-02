require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'
require 'sqlite3'

require_relative '../app/models/restaurant.rb'
require_relative '../app/models/customer.rb'
require_relative '../app/models/review.rb'
require_relative '../info.rb'

require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/yelp_app.sqlite"
)
