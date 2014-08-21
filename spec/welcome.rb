require 'selenium-webdriver'
require 'rspec'

RSpec.configure do |config| config.color_enabled = true end

describe "The welcome demo" do

  before(:all) do
    browserstack_user = ENV['BROWSERSTACK_USER']
    browserstack_key = ENV['BROWSERSTACK_KEY']
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps['os'] = 'windows'
    caps['os_version'] = '7'
    caps['browser'] = 'chrome'
    caps['browserstack.local'] = true
    caps['browserstack.debug'] = true
    caps['build'] = 'Travis'
    caps['name'] = ENV['TRAVIS_BUILD_NUMBER'] || ''
    @driver = Selenium::WebDriver.for(:remote, :url => "http://#{browserstack_user}:#{browserstack_key}@hub.browserstack.com/wd/hub", :desired_capabilities => caps) 
 end

  after(:all) do
    @driver.quit
  end
  
  it "should have a welcome page" do
    username = 'Test User'
    @driver.get 'http://localhost:8001'
    @driver.find_element(:name ,'name').send_keys username
    @driver.find_element(:css, "input[type='submit']").click
    actual_text = @driver.find_element(:css, "h2").text
    actual_text.should == "Welcome, #{username}"
  end

end
