json.assignees do
    json.array!(@assignees) do |assigned|
      json.partial! "assigned", locals: { assigned: assigned }
    end
  end
