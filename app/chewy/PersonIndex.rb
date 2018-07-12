class PersonIndex < Chewy::Index
  define_type Person.includes(:posts, :message_reports, :messages, :post_reactions, :room_memberships, :quest_completions, :step_completed, :quest_completed, :rewards, :level_progresses, :reward_progresses) do
  end
end
