require 'helper'

class TestNginxHttpPushConnector < Test::Unit::TestCase
  context "Base" do
    setup do
      @hydra = Typhoeus::Hydra.hydra
      @hydra.clear_stubs
    end
    
    context "request" do
      should "sends Accepts header of text/json if none specified" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 200, :body => File.read(File.join(fixture_path, "valid_response"))))
        
        request = NginxHttpPush::Base.request(:get, :uri => "http://127.0.0.1/publish?id=1").request
        
        assert_equal "application/json", request.headers["Accept"]
      end
      
      should "sends Accepts header as specified" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 200, :body => File.read(File.join(fixture_path, "valid_response"))))
        
        request = NginxHttpPush::Base.request(:get, :headers => {"Accept" => "text/xml"}, :uri => "http://127.0.0.1/publish?id=1").request
        
        assert_equal "text/xml", request.headers["Accept"]
      end
    end
  end
  
  context "A Publisher's" do
    setup do
      @hydra = Typhoeus::Hydra.hydra
      @hydra.clear_stubs
    end
    
    context "status" do
      should "allow and parse 200 responses" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 200, :body => File.read(File.join(fixture_path, "valid_response"))))
        
        response = NginxHttpPush::Publisher.status(1)
        
        assert_equal 200, response["code"]
        assert_equal 1, response["messages"]
        assert_equal 19, response["requested"]
        assert_equal 0, response["subscribers"]
      end
      
      should "throw error with 404 response" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 404, :body => ""))
        
        assert_raise NginxHttpPush::QueueNotFound do
          NginxHttpPush::Publisher.status(1)
        end
      end
      
      should "throw error with response other than 200 or 404" do
        @hydra.stub(:get, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 500, :body => ""))
        
        assert_raise NginxHttpPush::UnknownResponse do
          NginxHttpPush::Publisher.status(1)
        end
      end
    end # end status context
    
    context "create" do
      should "allow and parse 200 responses" do
        @hydra.stub(:put, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 200, :body => File.read(File.join(fixture_path, "valid_response"))))
        
        response = NginxHttpPush::Publisher.create(1)
        
        assert_equal 200, response["code"]
        assert_equal 1, response["messages"]
        assert_equal 19, response["requested"]
        assert_equal 0, response["subscribers"]
      end
      
      should "throw error with response other than 200" do
        @hydra.stub(:put, "http://127.0.0.1/publish?id=1").and_return(Typhoeus::Response.new(:code => 500, :body => ""))
        
        assert_raise NginxHttpPush::UnknownResponse do
          NginxHttpPush::Publisher.create(1)
        end
      end
    end # end create context
    
    context "add" do
      
    end # end add context
  end
end
