require 'rubygems'

module NginxHttpPush
  class NginxHttpPushError < StandardError
    attr_reader :data
    
    def initialize(data)
      @data = data
      super
    end
  end
  
  class QueueNotFound < NginxHttpPushError; end
  class QueueRemoved < NginxHttpPushError; end
  class UnknownResponse < NginxHttpPushError; end
end

def require_local(suffix)
  require(File.expand_path(File.join(File.dirname(__FILE__), suffix)))
end

require 'typhoeus'
require 'configatron'
require 'uri'

require_local File.join('nginx-http-push-connector','base')
require_local File.join('nginx-http-push-connector','publisher')
require_local File.join('nginx-http-push-connector','subscriber')