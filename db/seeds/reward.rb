Reward.create!(
  name: {"un" => "Chat for 30 minutes"}, internal_name: "chat_for_30_minutes",  series: "chat_30_daily", completion_requirement: 30, points: 250,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "chat_for_30_minutes").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "React to 10 posts"}, internal_name: "react_to_10_posts", series: "react_post", completion_requirement: 10, points: 100,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "react_10_posts").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Chat 10 60"}, internal_name: "chat_10_60", series: "chat_10_daily", completion_requirement: 60, points: 200,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "chat_10_60").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Chat for 60 minutes"}, internal_name: "chat_for_60_minutes", series: "chat_60_daily", completion_requirement: 10, points: 1000,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "chat_60").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Follow 200"}, internal_name: "follow_200", series: "follow_person", completion_requirement: 200, points: 250,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "follow_200").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Follow 50"}, internal_name: "follow_50", series: "follow_person", completion_requirement: 50, points: 100,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "follow_50").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Follow 10 People"}, internal_name: "follow_10_people", series: "follow_person", completion_requirement: 10, points: 25,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "follow_10").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Active for 90 days"}, internal_name: "active_for_90_days", series: "open_app_daily", completion_requirement: 90, points: 500,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "daily_activity_90").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Active for 7 Days"}, internal_name: "active_for_7_days", series: "open_app_daily", completion_requirement: 7, points: 100,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "daily_activity_7").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Active for 30 days"}, internal_name: "active_for_30_days", series: "open_app_daily", completion_requirement: 30, points: 250,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "daily_activity_30").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Chat 10 30"}, internal_name: "chat_10_30", series: "chat_10_daily", completion_requirement: 10, points: 150,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "chat_10_30").first.id, status: "active", deleted: false,
)
Reward.create!(
  name: {"un" => "Chat for 10 minutes"}, internal_name: "chat_for_10_minutes", series: "chat_10_daily", completion_requirement: 7, points: 100,
  reward_type: "badge", reward_type_id: Badge.where(internal_name: "chat_10_7").first.id, status: "active", deleted: false,
)
