module NginxHttpPush
  class Publisher < NginxHttpPush::Base
    def self.status(channel_id)
      response = Typhoeus::Request.get(uri(:publisher, channel_id))
      data = parse(response)
      case response.code.to_i
      when 200
        data
      when 404
        raise QueueNotFound, "(#{response.code}): Queue does not exist" 
      else
        raise UnknownResponse.new(data), "(#{response.code}): Response not included in protocol - #{data.inspect if data}"
      end
    end
  end
end