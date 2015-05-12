# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

configure do
  # By default, Sinatra assumes that the root is the file that calls the configure block.
  # Since this is not the case for us, we set it manually.
  set :root, APP_ROOT.to_path
  # See: http://www.sinatrarb.com/faq.html#sessions
  enable :sessions
  set :session_secret, ENV['SESSION_SECRET'] || 'this is a secret shhhhh'

  # Set the views to
  set :views, File.join(Sinatra::Application.root, "app", "views")
end

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Set up Amazon ECS

# Configure your access key, secret key and other options such as the associate tag.
# Options set in the configure block will add/update to the default options, i.e.
#  options[:version] => "2011-08-01"
#  options[:service] => "AWSECommerceService"
Amazon::Ecs.configure do |options|
  options[:AWS_access_key_id] = ENV['AMAZON_ACCESS_KEY']
  options[:AWS_secret_key] = ENV['AMAZON_SECRET_KEY']
  options[:associate_tag] = ENV['AMAZON_ASSOCIATE_TAG']
end

# Or if you need to replace the default options, set the options value directly.
# Amazon::Ecs.options = {
#  :version => "2013-08-01",
#  :service => "AWSECommerceService"
#  :associate_tag => '[your associate tag]',
#  :AWS_access_key_id => '[your developer token]',
#  :AWS_secret_key => '[your secret access key]'
# }
