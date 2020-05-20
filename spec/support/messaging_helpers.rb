# frozen_string_literal: true
module MessagingHelpers
  class ResponseStatus
    def status
      200
    end
  end
  class Response
    def response
      ResponseStatus.new
    end
  end

  class FBStub
    def new
    end

    def delete(k)
    end

    def set(k, v)
    end

    def update(path, data, query = {})
      process :patch, path, data, query
    end

    def process(verb, path, data = nil, query = {})
      Response.new
    end
  end

  class Implementer
    include Messaging
  end
end
