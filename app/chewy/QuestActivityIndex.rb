class QuestActivityIndex < Chewy::Index
  define_type QuestActivity.includes(:activity_types) do
  end
end
