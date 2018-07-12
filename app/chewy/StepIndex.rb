class StepIndex < Chewy::Index
  define_type Step.includes(:quest_activities) do
  end
end
