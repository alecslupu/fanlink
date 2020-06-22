# frozen_string_literal: true

json.steps do
    json.array!(@steps) do |step|
      if !step.deleted
        json.id step.id
        if step.display?
          json.display step.display
        else
          json.display "Step #{step.id}"
        end
      end
    end
  end
