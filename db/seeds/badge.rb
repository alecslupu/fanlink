Badge.create!(
  name: {"un" => "Chat for 10 Minutes"}, internal_name: "chat_10_7", action_requirement: 7, point_value: 10,
  description: {"un" => "Be active in a chat room for 10 minutes once per day."},
  action_type_id: ActionType.where(internal_name: "chat_10_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/chat_10_7.png")),
)
Badge.create!(
  name: {"un" => "Chat for 10 Minutes for 30D"}, internal_name: "chat_10_30", action_requirement: 30, point_value: 15,
  description: {"un" => "Be active in a chat room for 10 minutes every day for 30 days."},
  action_type_id: ActionType.where(internal_name: "chat_10_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/chat_10_30.png")),
)
Badge.create!(
  name: {"un" => "Chat for 10 Minutes for 60D"}, internal_name: "chat_10_60", action_requirement: 60, point_value: 200,
  description: {"un" => "Be active in a chat room for 10 minutes every day for 60 days."},
  action_type_id: ActionType.where(internal_name: "chat_10_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/chat_10_60.png")),
)
Badge.create!(
  name: {"un" => "Active for 7 Days"}, internal_name: "daily_activity_7", action_requirement: 7, point_value: 100,
  description: {"un" => "Open the app once a day for 7 days."},
  action_type_id: ActionType.where(internal_name: "open_app_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/daily_activity_7.png")),
)
Badge.create!(
  name: {"un" => "Active for 30 Days"}, internal_name: "daily_activity_30", action_requirement: 30, point_value: 250,
  description: {"un" => "Open the app every day for 30 days."},
  action_type_id: ActionType.where(internal_name: "open_app_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/daily_activity_30.png")),
)
Badge.create!(
  name: {"un" => "Active for 90 Days"}, internal_name: "daily_activity_90", action_requirement: 90, point_value: 500,
  description: {"un" => "Open the app once every day for 90 days."},
  action_type_id: ActionType.where(internal_name: "open_app_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/daily_activity_90.png")),
)
Badge.create!(
  name: {"un" => "Follow 10 People"},  internal_name: "follow_10", action_requirement: 10, point_value: 25,
  description: {"un" => "To follow a user, visit and tap the \"Follow\" icon."},
  action_type_id: ActionType.where(internal_name: "follow_person").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/follow_10.png")),
)
Badge.create!(
  name: {"un" => "Follow 50 People"}, internal_name: "follow_50", action_requirement: 50, point_value: 100,
  description: {"un" => "To follow a user, visit and tap the \"Follow\" icon."},
  action_type_id: ActionType.where(internal_name: "follow_person").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/follow_50.png")),
)
Badge.create!(
  name: {"un" => "Follow 200 People"}, internal_name: "follow_200", action_requirement: 200, point_value: 250,
  description: {"un" => "To follow a user, visit and tap the \"Follow\" icon."},
  action_type_id: ActionType.where(internal_name: "follow_person").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/follow_200.png")),
)
Badge.create!(
  name: {"un" => "Chat for 30 minutes"}, internal_name: "chat_for_30_minutes", action_requirement: 10, point_value: 250,
  description: {"un" => "Be active in a chat room for 30 minutes every day for 7 days."},
  action_type_id: ActionType.where(internal_name: "chat_30_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/chat_for_30_minutes.png")),
)
Badge.create!(
  name: {"un" => "Chat for 60 Minutes"}, internal_name: "chat_60", action_requirement: 10, point_value: 1000,
  description: {"un" => "Be active in a chat room for 60 minutes every day for 10 days."},
  action_type_id: ActionType.where(internal_name: "chat_60_daily").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/chat_60.png")),
)
Badge.create!(
  name: {"un" => "React To your favorite 10 posts"}, internal_name: "react_10_posts", action_requirement: 10, point_value: 100,
  description: {"un" => "React to your top 10 posts"},
  action_type_id: ActionType.where(internal_name: "react_post").id,
  picture: File.open(Rails.root.join("db/seeds/files/badges/react_10_posts.png")),
)
