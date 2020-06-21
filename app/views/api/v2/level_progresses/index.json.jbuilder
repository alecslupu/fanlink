# frozen_string_literal: true

json.levels do
    json.array!(@progress) do |progress|
      json.partial! 'level_progress', locals: { level: progress }
    end
  end
