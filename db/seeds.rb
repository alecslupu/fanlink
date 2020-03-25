# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# if ENV["SEED_DB"] && Rails.env.development?
#   if Product.count == 0
#     Product.create(name: "Admin", internal_name: "admin", can_have_supers: true, enabled: true, age_requirement: 18)
#     unless Rails.env.production?
#       Product.create(name: "Test Product", internal_name: "test", age_requirement: 21)
#       Product.create(name: "Test Product2", internal_name: "test2", age_requirement: 13)
#     end
#   end
#
#   if Person.count == 0
#     unless Rails.env.production?
#       Person.create(name: "Admin User", username: "admin", product_id: Product.find_by(internal_name: "admin").id, email: "admin@example.com",
#                     password: "flink_admin", role: :super_admin, birthdate: "1982-01-01")
#       Person.create(name: "Some User", username: "some_user", product_id: Product.find_by(internal_name: "test").id, email: "somebody@example.com", password: "password", birthdate: "1982-01-01")
#       Person.create(name: "Some Banned User", username: "some_banned_user", product_id: Product.find_by(internal_name: "test").id, email: "banned@example.com", password: "password", birthdate: "1982-01-01", terminated: true)
#     end
#   end
#
#   if Room.count < 10
#     unless Rails.env.production?
#       prod = Product.find_by(internal_name: "test").try(:id)
#       u = Person.find_by(name: "Admin User").try(:id)
#       if prod && u
#         1.upto 10 do |n|
#           unless (Room.where(id: n)).exists?
#             Room.create(name: "Public room #{n}", created_by_id: u, public: true, product_id: prod, status: :active)
#           end
#         end
#       end
#     end
#   end
#
#   if ActionType.count == 0
#     unless Rails.env.production?
#       ActionType.create!([
#         {name: "Crashed the App", internal_name: "crashed_app", seconds_lag: 10, active: true},
#         {name: "Threw up", internal_name: "threw_up", seconds_lag: 0, active: true},
#         {name: "Unapplied", internal_name: "unapplied_action", seconds_lag: 0, active: true},
#         {name: "Open App Daily", internal_name: "open_app_daily", seconds_lag: 86400, active: true},
#         {name: "Create Post", internal_name: "create_post", seconds_lag: 0, active: true},
#         {name: "Follow Person", internal_name: "follow_person", seconds_lag: 0, active: true},
#         {name: "Chat 10 Min Daily", internal_name: "chat_10_daily", seconds_lag: 86400, active: true},
#         {name: "Chat 30 Min Daily", internal_name: "chat_30_daily", seconds_lag: 86400, active: true},
#         {name: "Chat 60 Min Daily", internal_name: "chat_60_daily", seconds_lag: 86400, active: true},
#         {name: "React to Post", internal_name: "react_post", seconds_lag: 0, active: true},
#         {name: "Share Post", internal_name: "share_post", seconds_lag: 0, active: true},
#         {name: "Share Post Person", internal_name: "share_post_person", seconds_lag: 0, active: true},
#         {name: "Invite Person", internal_name: "invite_person", seconds_lag: 0, active: true},
#         {name: "Complete Profile", internal_name: "complete_profile", seconds_lag: 0, active: true},
#         {name: "Complete Quest", internal_name: "complete_quest", seconds_lag: 0, active: true}
#       ])
#     end
#   end
#
#   if Badge.count == 0
#     unless Rails.env.production?
#       Badge.create!([
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Chat for 60 Minutes", internal_name: "chat_60", action_type_id: 13, action_requirement: 10, point_value: 1000, picture_file_name: "Chat_60_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41190, picture_updated_at: "2018-02-21 04:47:34", description_text_old: "Be active in a chat room for 60 minutes per day for 10 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 60 Minutes"}, description: {"un"=>"Be active in a chat room for 60 minutes per day for 10 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Chat for 30 Minutes", internal_name: "chat_30", action_type_id: 12, action_requirement: 7, point_value: 250, picture_file_name: "Chat_30_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41740, picture_updated_at: "2018-02-21 04:47:07", description_text_old: "Be active in a chat room for 30 minutes per day for 7 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 30 Minutes"}, description: {"un"=>"Be active in a chat room for 30 minutes per day for 7 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Chat for 10 Minutes", internal_name: "chat_10_7", action_type_id: 10, action_requirement: 7, point_value: 10, picture_file_name: "Chat_10_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41116, picture_updated_at: "2018-02-21 04:44:36", description_text_old: "Be active in a chat room for 10 minutes every day for 7 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 10 Minutes"}, description: {"un"=>"Be active in a chat room for 10 minutes every day for 7 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Chat for 10 Minutes for 30D", internal_name: "chat_10_30", action_type_id: 10, action_requirement: 30, point_value: 15, picture_file_name: "Chat_10_-_Level_2.png", picture_content_type: "image/png", picture_file_size: 45002, picture_updated_at: "2018-02-21 04:45:39", description_text_old: "Be active in a chat room for 10 minutes per day for 30 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 10 Minutes for 30D"}, description: {"un"=>"Be active in a chat room for 10 minutes per day for 30 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Chat for 10 Minutes for 90D", internal_name: "chat_10_90", action_type_id: 10, action_requirement: 90, point_value: 20, picture_file_name: "Chat_10_-_Level_3.png", picture_content_type: "image/png", picture_file_size: 33420, picture_updated_at: "2018-02-21 04:46:29", description_text_old: "Be active in a chat room for 10 minutes per day for 60 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 10 Minutes for 90D"}, description: {"un"=>"Be active in a chat room for 10 minutes per day for 60 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Active for 7 Days", internal_name: "daily_activity_7", action_type_id: 5, action_requirement: 7, point_value: 100, picture_file_name: "Login_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 35547, picture_updated_at: "2018-02-21 04:49:59", description_text_old: "Open the app every day for 7 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Active for 7 Days"}, description: {"un"=>"Open the app every day for 7 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Active for 30 Days", internal_name: "daily_activity_30", action_type_id: 5, action_requirement: 30, point_value: 250, picture_file_name: "Login_-_Level_2.png", picture_content_type: "image/png", picture_file_size: 38366, picture_updated_at: "2018-02-21 04:50:36", description_text_old: "Open the app every day for 30 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Active for 30 Days"}, description: {"un"=>"Open the app every day for 30 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Active for 90 Days", internal_name: "daily_activity_90", action_type_id: 5, action_requirement: 90, point_value: 500, picture_file_name: "Login_-_Level_3.png", picture_content_type: "image/png", picture_file_size: 27687, picture_updated_at: "2018-02-21 04:51:10", description_text_old: "Open the app every day for 90 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Active for 90 Days"}, description: {"un"=>"Open the app every day for 90 days."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Follow 25 People", internal_name: "follow_25", action_type_id: 8, action_requirement: 25, point_value: 25, picture_file_name: "Follow_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 35176, picture_updated_at: "2018-02-21 04:48:11", description_text_old: "To follow a user visit their profile and tap the \"Follow\" icon.", issued_from: nil, issued_to: nil, name: {"un"=>"Follow 25 People"}, description: {"un"=>"To follow a user visit their profile and tap the \"Follow\" icon."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Follow 100 People", internal_name: "follow_100", action_type_id: 8, action_requirement: 100, point_value: 100, picture_file_name: "Follow_-_Level_2.png", picture_content_type: "image/png", picture_file_size: 37862, picture_updated_at: "2018-02-21 04:48:48", description_text_old: "To follow a user visit their profile and tap the \"Follow\" button.", issued_from: nil, issued_to: nil, name: {"un"=>"Follow 100 People"}, description: {"un"=>"To follow a user visit their profile and tap the \"Follow\" button."}},
#         {product_id: Product.find_by(internal_name: "test").id, name_text_old: "Follow 250 People", internal_name: "follow_250", action_type_id: 8, action_requirement: 250, point_value: 250, picture_file_name: "Follow_-_Level_3.png", picture_content_type: "image/png", picture_file_size: 27029, picture_updated_at: "2018-02-21 04:49:20", description_text_old: "To follow a user visit their profile and tap the \"Follow\" button.", issued_from: nil, issued_to: nil, name: {"un"=>"Follow 250 People"}, description: {"un"=>"To follow a user visit their profile and tap the \"Follow\" button."}}
#       ])
#     end
#   end
#
#     # if BadgeAward.count == 0
#     #   unless Rails.env.production?
#     #     BadgeAward.create!([
#     #       {person_id: 2, badge_id: 1},
#     #       {person_id: 2, badge_id: 2},
#     #       {person_id: 2, badge_id: 3},
#     #       {person_id: 2, badge_id: 4},
#     #       {person_id: 2, badge_id: 5},
#     #       {person_id: 2, badge_id: 6},
#     #       {person_id: 2, badge_id: 7},
#     #       {person_id: 2, badge_id: 8},
#     #       {person_id: 2, badge_id: 9},
#     #       {person_id: 2, badge_id: 10},
#     #       {person_id: 2, badge_id: 11}
#     #     ])
#     #   end
#     # end
#
#   if Category.count == 0
#     unless Rails.env.production?
#       Product.all.each do |p|
#         Category.create(name: "Uncategorized", color: "#ffffff", role: :normal, product_id: p.id)
#       end
#     end
#   end
#
#   if Reward.count == 0
#     unless Rails.env.production?
#       Reward.create([
#         {product_id: Product.find_by(internal_name: "test").id, name: "Chat 30 minutes", internal_name: "chat_30_daily", series: "chat_daily", completion_requirement: 30, points: 30, reward_type: :badge, reward_type_id: Badge.find_by(internal_name: "chat_30").id, status: :active},
#         {product_id: Product.find_by(internal_name: "test").id, name:  "Chat 60 minutes", internal_name: "chat_60_daily", series: "chat_daily", completion_requirement: 60, points: 60, reward_type: :badge, reward_type_id: Badge.find_by(internal_name: "chat_60").id, status: :active}
#       ])
#     end
#   end
#
#   if AssignedReward.count == 0
#     unless Rails.env.production?
#       AssignedReward.create([
#         {reward_id: Reward.find_by(internal_name: 'chat_30_daily').id, assigned_type: 'ActionType', assigned_id: ActionType.find_by(internal_name: 'chat_30_daily').id},
#         {reward_id: Reward.find_by(internal_name: 'chat_60_daily').id, assigned_type: 'ActionType', assigned_id: ActionType.find_by(internal_name: 'chat_60_daily').id }
#       ])
#     end
#   end
#
#   if Post.count == 0
#     unless Rails.env.production?
#
#     end
#   end
#
#   if PostComment.count == 0
#     unless Rails.env.production?
#
#     end
#   end
# end
