# frozen_string_literal: true

class SnsContentType
  def initialize(app)
    @app = app
  end

  def call(env)
    env["CONTENT_TYPE"] = "application/json" if env["HTTP_X_AMZ_SNS_MESSAGE_TYPE"].present?
    @app.call(env)
  end
end
