$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'rack/favicon_all'
require 'hello_world'

use Rack::FaviconAll, favicon_path: "./icon.png"
run HelloWorld.new
