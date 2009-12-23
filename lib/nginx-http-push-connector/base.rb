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
      if body = response.body
        Hash[YAML::load(body.to_s).collect{|k,v| [k.gsub(/\s/,"_").to_sym, v.to_i]}]
      else
        {}
      end.merge({:code => response.code.to_i})
    end
  end
end