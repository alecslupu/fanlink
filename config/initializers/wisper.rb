Rails.application.config.to_prepare do
    Wisper.clear if Rails.env.development?
    Wisper.subscribe(BeaconsListener)
    Wisper.subscribe(TagListener)
  end
