ActionType.create!([
  {name: "Crashed the App", internal_name: "crashed_app", seconds_lag: 10, active: true},
  {name: "Threw up", internal_name: "threw_up", seconds_lag: 0, active: true},
  {name: "Unapplied", internal_name: "unapplied_action", seconds_lag: 0, active: true},
  {name: "Create Post", internal_name: "create_post", seconds_lag: 0, active: true},
  {name: "Follow Person", internal_name: "follow_person", seconds_lag: 0, active: true},
  {name: "Chat 10 Min Daily", internal_name: "chat_10_daily", seconds_lag: 86400, active: true},
  {name: "Chat 30 Min Daily", internal_name: "chat_30_daily", seconds_lag: 86400, active: true},
  {name: "Chat 60 Min Daily", internal_name: "chat_60_daily", seconds_lag: 86400, active: true},
  {name: "Complete Quest", internal_name: "complete_quest", seconds_lag: 0, active: true},
  {name: "React to Post", internal_name: "react_post", seconds_lag: 0, active: true},
  {name: "Open App Daily", internal_name: "open_app_daily", seconds_lag: 86400, active: true},
  {name: "Share Post", internal_name: "share_post", seconds_lag: 0, active: true},
  {name: "Share Post Person", internal_name: "share_post_person", seconds_lag: 0, active: true},
  {name: "Invite Person", internal_name: "invite_person", seconds_lag: 0, active: true},
  {name: "Complete Profile", internal_name: "complete_profile", seconds_lag: 0, active: true}
])
