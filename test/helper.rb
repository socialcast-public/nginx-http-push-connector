require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'nginx-http-push-connector'

class Test::Unit::TestCase
  def fixture_path
    File.join(File.dirname(__FILE__), "fixtures")
  end
end
