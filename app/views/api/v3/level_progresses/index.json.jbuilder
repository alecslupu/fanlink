json.levels do
    json.array!(@progress) do |progress|
        json.cache! ['v3', progress] do
            json.partial! "level_progress", locals: { level: progress }
        end
    end
  end
