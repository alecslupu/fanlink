json.action_types do
    json.array!(@action_types) do |action|
        if action.active?
            json.id action.id
            json.name action.name
            json.internal_name action.internal_name
        end
    end
end
