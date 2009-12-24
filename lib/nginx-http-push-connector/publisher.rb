module NginxHttpPush
  class Publisher < NginxHttpPush::Base
    def self.status(channel_id)
      response = request(:get, :uri => uri(:publisher, channel_id))
      data = parse(response)
      case response.code.to_i
      when 200
        data
      when 404
        raise QueueNotFound, "(#{response.code}): Queue does not exist" 
      else
        raise UnknownResponse.new(data), "(#{response.code}): Response not included in protocol - #{response.body.inspect} - #{data.inspect if data}"
      end
    end
    
    def self.create(channel_id)
      response = request(:put, :uri => uri(:publisher, channel_id))
      data = parse(response)
      case response.code.to_i
      when 200
        data
      else
        raise UnknownResponse.new(data), "(#{response.code}): Response not included in protocol - #{response.body.inspect} - #{data.inspect if data}"
      end
      
    end
  end
end