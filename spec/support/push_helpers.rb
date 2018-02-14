module PushHelpers

  class FBCMStub
    def send(tokens, options)
    end
  end

  class Implementer
    include Push
  end
end
