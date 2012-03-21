require "rubygems"
require "bundler/setup"

require 'rspec'

require 'mongoid'
require File.expand_path('../../lib/mongoid_genesis', __FILE__)


Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db('mongoid_genesis_test')
  config.allow_dynamic_fields = false
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.after :each do
    Mongoid.master.collections.reject { |c| c.name =~ /^system\./ }.each(&:drop)
  end
end
