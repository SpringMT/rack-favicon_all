require 'bundler'
Bundler.setup(:default, :test)
Bundler.require(:default, :test)

require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

$TESTING=true
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib/rack/')
require 'rack/favicon_all'

