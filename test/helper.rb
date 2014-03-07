require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'ruby-redtail'

class Test::Unit::TestCase
  def setup_redtail
    @redtail_api_key = 'E45FC97D-5AB2-4FD7-B05F-80BC64227A80'
    @redtail_secret_key = '31CE58601D694E31B681C209D29936F6'
    @redtail_uri = 'http://dev.api2.redtailtechnology.com/crm/v1/rest'
    @redtail_user_key = 'CF5DAEC8-4F73-404C-9F1A-8C944F2DDC51'
    @redtail_user_name = 'Statementone'
    @redtail_user_password = 'sonedemo'
    @num = 4
    RubyRedtail.configure do |config|
      config.api_key = @redtail_api_key
      config.secret_key = @redtail_secret_key
      config.api_uri = @redtail_uri
    end
  end
end
