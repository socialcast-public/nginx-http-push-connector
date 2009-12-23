require 'helper'

class TestNginxHttpPushConnector < Test::Unit::TestCase
  context "A Publisher's" do
    setup do
      @hydra = Typhoeus::Hydra.hydra
      @hydra.clear_stubs
      @valid_response = "queued messages: 1\r\nlast requested: 19 sec. ago (-1=never)\r\nactive subscribers: 0"
      @expired_response ="queued messages: 1\r\nlast requested: 121 sec. ago (-1=never)\r\nactive subscribers: 0"
    end
    
    context "status" do
      should "allow 200 responses" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 200, :body => @valid_response))
        
        response = NginxHttpPush::Publisher.status(1)
        
        assert_equal 200, response[:code]
        assert_equal 1, response[:queued_messages]
        assert_equal 19, response[:last_requested]
        assert_equal 0, response[:active_subscribers]
      end
      
      should "throw error with 404 response" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 404))
        
        assert_raise NginxHttpPush::QueueNotFound do
          NginxHttpPush::Publisher.status(1)
        end
      end
      
      should "throw error with response other than 200 or 404" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 500))
        
        assert_raise NginxHttpPush::UnknownResponse do
          NginxHttpPush::Publisher.status(1)
        end
      end
    end
  end
end
