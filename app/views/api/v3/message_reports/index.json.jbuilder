# frozen_string_literal: true

json.message_reports do
  json.array!(@message_reports) do |mr|
    json.partial! 'message_report', locals: { message_report: mr }
  end
end
