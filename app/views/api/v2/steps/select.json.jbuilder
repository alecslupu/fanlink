json.steps do
    json.array!(@steps) do |step|
        if !step.deleted
            json.id step.id
            if step.display?
                json.display step.display
            else
                json.display "Step #{step.id.to_s}"
            end
        end
    end
  end
