module NginxHttpPush
  class Base
    configatron.nhp.publisher.set_default(:host, '127.0.0.1')
    configatron.nhp.publisher.set_default(:port, 80)
    configatron.nhp.publisher.set_default(:path, ['publish'])
    configatron.nhp.publisher.set_default(:channel_identifier, 'id')
    
    configatron.nhp.subscriber.set_default(:host, '127.0.0.1')
    configatron.nhp.subscriber.set_default(:host, 80)
    configatron.nhp.subscriber.set_default(:path, ['activity'])
    configatron.nhp.subscriber.set_default(:channel_identifier, 'id')
    
    def self.uri(type, channel_id)
      config = configatron.nhp.send(type.to_sym)
      URI.parse("#{config.port == 443 ? "https" : "http"}://#{config.host}:#{config.port}/#{File.join(config.path)}?#{config.channel_identifier}=#{channel_id}").to_s
    end
    
    def self.parse(response)
      (Crack::JSON.parse(response.body.to_s) || {}).merge({"code" => response.code.to_i})
    end
    
    def self.request(method, options={})
      options[:headers] = {} if options[:headers].nil?
      options[:headers].merge!({"Accept" => 'application/json'}) if options[:headers]["Accept"].nil?
      Typhoeus::Request.send(method.to_sym, options.delete(:uri), options)
    end
  end
end