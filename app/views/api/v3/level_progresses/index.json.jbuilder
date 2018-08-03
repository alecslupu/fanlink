json.levels do
    json.array!(@progress) do |progress|
      json.partial! "level_progress", locals: { level: progress }
    end
  end
