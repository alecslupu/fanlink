json.interests do
  json.array! @interests do |i|
    json.interest do
      json.partial! "interest", locals: {interest: i}
    end
  end
end
