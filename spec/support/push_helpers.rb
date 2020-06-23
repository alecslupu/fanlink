# frozen_string_literal: true

module PushHelpers
  class FBCMStub
    def send(tokens, options)
    end
  end

  class Implementer
    include Push
  end

  def get_options(tit, body, type, data = {})
    options = {}
    options[:notification] = {}
    options[:notification][:title] = tit
    options[:notification][:body] = body
    options[:notification][:sound] = 'default'
    options[:content_available] = true
    options[:data] = data
    options[:data][:notification_type] = type
    options[:data][:priority] = 'high'
    options
  end
end
