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
    def delete(k)
    end
    def set(k, v)
    end
    def update(es, pl)
    end
  end

  class Implementer
    include Messaging
  end
end
