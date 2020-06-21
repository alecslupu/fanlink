# frozen_string_literal: true

json.cache! ["v3", polls] do
  json.id polls.id.to_s
  json.post_id polls.post.id
  json.description polls.description
  json.created_at polls.created_at.to_s
  json.updated_at polls.updated_at.to_s
  json.start_date polls.start_date
  json.duration polls.duration
  json.poll_status polls.poll_status
  if polls.poll_options.present?
    json.poll_options do
      polls.poll_options.each do |poll_option|
        json.description poll_option.description
      end
    end
  end
end
