# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require :default, :development

Combustion.initialize! :all
run Combustion::Application

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
