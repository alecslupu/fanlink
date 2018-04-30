Person.create!([
  {username: "admin", username_canonical: "admin", email: "admin@example.com", name: "Admin User", product_id: 1, crypted_password: "$2a$10$n1fxYa4v.ZllKSPea7/EYespuN05hXdGyp4HJ5sjjRFi1d368s1Xe", salt: "mefAogpVxkyKhi3A8EqV", facebookid: nil, facebook_picture_url: nil, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, do_not_message_me: false, pin_messages_from: false, auto_follow: false, role: "super_admin", reset_password_token: nil, reset_password_token_expires_at: nil, reset_password_email_sent_at: nil, product_account: false, chat_banned: false, recommended: false, designation: {}},
  {username: "some_user", username_canonical: "someuser", email: "somebody@example.com", name: "Some User", product_id: 2, crypted_password: "$2a$10$sZr4a8sFDmiMi0ql9rWPo.hU8DopCSSGlXsnRrQuvCoESfNBk45PW", salt: "sCoRnMp8q86PDyq5-yRS", facebookid: nil, facebook_picture_url: nil, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, do_not_message_me: false, pin_messages_from: false, auto_follow: false, role: "normal", reset_password_token: nil, reset_password_token_expires_at: nil, reset_password_email_sent_at: nil, product_account: false, chat_banned: false, recommended: false, designation: {}}
])
Following.create!([
  {follower_id: 101, followed_id: 32},
  {follower_id: 105, followed_id: 84},
  {follower_id: 107, followed_id: 26},
  {follower_id: 15, followed_id: 3},
  {follower_id: 15, followed_id: 19}
])
Room.create!([
  {product_id: 5, name_text_old: nil, created_by_id: 44, status: "active", public: false, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, name: {}, description: {}},
  {product_id: 5, name_text_old: nil, created_by_id: 26, status: "active", public: false, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, name: {}, description: {}},
  {product_id: 5, name_text_old: nil, created_by_id: 26, status: "active", public: false, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, name: {}, description: {}},
  {product_id: 5, name_text_old: nil, created_by_id: 26, status: "active", public: false, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, name: {}, description: {}},
  {product_id: 5, name_text_old: nil, created_by_id: 26, status: "active", public: false, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, name: {}, description: {}}
])
MessageReport.create!([
  {message_id: 462, person_id: 32, reason: "I have no reason.", status: "message_hidden"},
  {message_id: 635, person_id: 22, reason: "bad", status: "message_hidden"},
  {message_id: 633, person_id: 22, reason: "", status: "message_hidden"},
  {message_id: 670, person_id: 45, reason: "because", status: "message_hidden"},
  {message_id: 671, person_id: 45, reason: "Because I said", status: "message_hidden"}
])
Message.create!([
  {person_id: 15, room_id: 18, body: "1", hidden: false, status: "pending", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil},
  {person_id: 41, room_id: 38, body: "🐱", hidden: false, status: "pending", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil},
  {person_id: 22, room_id: 76, body: "8", hidden: false, status: "pending", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil},
  {person_id: 22, room_id: 22, body: "Hi", hidden: false, status: "pending", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil},
  {person_id: 22, room_id: 23, body: "Hi", hidden: false, status: "pending", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil}
])
Post.create!([
  {person_id: 22, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "published", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {}, priority: 0},
  {person_id: 74, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "deleted", picture_file_name: "image.jpg", picture_content_type: "image/jpeg", picture_file_size: 3837690, picture_updated_at: "2018-02-26 23:16:52", body: {}, priority: 0},
  {person_id: 45, body_text_old: "", global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "rejected", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {}, priority: 0},
  {person_id: 45, body_text_old: "", global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "rejected", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {}, priority: 0},
  {person_id: 45, body_text_old: "", global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "rejected", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {}, priority: 0}
])
PostReaction.create!([
  {post_id: 331, person_id: 102, reaction: "1F44D"},
  {post_id: 333, person_id: 141, reaction: "1F62E"},
  {post_id: 332, person_id: 102, reaction: "1F3B6"},
  {post_id: 375, person_id: 22, reaction: "1F389"},
  {post_id: 333, person_id: 85, reaction: "1F44D"}
])
Relationship.create!([
  {requested_by_id: 3, requested_to_id: 21, status: "friended"},
  {requested_by_id: 100, requested_to_id: 26, status: "friended"},
  {requested_by_id: 15, requested_to_id: 17, status: "friended"},
  {requested_by_id: 21, requested_to_id: 17, status: "friended"},
  {requested_by_id: 42, requested_to_id: 30, status: "requested"}
])
ActionType.create!([
  {name: "Crashed the App", internal_name: "crashed_app", seconds_lag: 10, active: true},
  {name: "Threw up", internal_name: "threw_up", seconds_lag: 0, active: true},
  {name: "Unapplied", internal_name: "unapplied_action", seconds_lag: 0, active: true},
  {name: "Create Post", internal_name: "create_post", seconds_lag: 0, active: true},
  {name: "Follow Person", internal_name: "follow_person", seconds_lag: 0, active: true}
])
Badge.create!([
  {product_id: 4, name_text_old: "Regurgitator", internal_name: "regurgitator", action_type_id: 2, action_requirement: 5, point_value: 0, picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, description_text_old: nil, issued_from: nil, issued_to: nil, name: {"un"=>"Regurgitator"}, description: {}},
  {product_id: 4, name_text_old: "Flinkster Crasher", internal_name: "flinkster_crasher", action_type_id: 1, action_requirement: 3, point_value: 0, picture_file_name: "Highlander-hole_09b.jpg", picture_content_type: "image/jpeg", picture_file_size: 248254, picture_updated_at: "2018-01-31 02:02:47", description_text_old: nil, issued_from: nil, issued_to: nil, name: {"un"=>"Flinkster Crasher"}, description: {}},
  {product_id: 7, name_text_old: "Chat for 60 Minutes", internal_name: "chat_60", action_type_id: 13, action_requirement: 10, point_value: 1000, picture_file_name: "Chat_60_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41190, picture_updated_at: "2018-02-21 04:47:34", description_text_old: "Be active in a chat room for 60 minutes per day for 10 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 60 Minutes"}, description: {"un"=>"Be active in a chat room for 60 minutes per day for 10 days."}},
  {product_id: 7, name_text_old: "Chat for 30 Minutes", internal_name: "chat_30", action_type_id: 12, action_requirement: 7, point_value: 250, picture_file_name: "Chat_30_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41740, picture_updated_at: "2018-02-21 04:47:07", description_text_old: "Be active in a chat room for 30 minutes per day for 7 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 30 Minutes"}, description: {"un"=>"Be active in a chat room for 30 minutes per day for 7 days."}},
  {product_id: 7, name_text_old: "Chat for 10 Minutes", internal_name: "chat_10_7", action_type_id: 10, action_requirement: 7, point_value: 10, picture_file_name: "Chat_10_-_Level_1.png", picture_content_type: "image/png", picture_file_size: 41116, picture_updated_at: "2018-02-21 04:44:36", description_text_old: "Be active in a chat room for 10 minutes every day for 7 days.", issued_from: nil, issued_to: nil, name: {"un"=>"Chat for 10 Minutes"}, description: {"un"=>"Be active in a chat room for 10 minutes every day for 7 days."}}
])
BadgeAction.create!([
  {action_type_id: 1, person_id: 21, identifier: nil},
  {action_type_id: 3, person_id: 21, identifier: nil},
  {action_type_id: 2, person_id: 21, identifier: nil},
  {action_type_id: 2, person_id: 21, identifier: nil},
  {action_type_id: 1, person_id: 21, identifier: nil}
])
BadgeAward.create!([
  {person_id: 21, badge_id: 1},
  {person_id: 21, badge_id: 2},
  {person_id: 47, badge_id: 8},
  {person_id: 63, badge_id: 8},
  {person_id: 62, badge_id: 8}
])
Block.create!([
  {blocker_id: 22, blocked_id: 26},
  {blocker_id: 74, blocked_id: 31},
  {blocker_id: 41, blocked_id: 59}
])
Event.create!([
  {product_id: 7, name: "Tester", description: "This is a teset event", starts_at: "2018-03-19 10:00:00", ends_at: "2018-03-20 10:00:00", ticket_url: "https://www.google.com", place_identifier: "ChIJOV4Pe03EyIARDGQ__xHAMJ0"}
])
Level.create!([
  {product_id: 4, name_text_old: "Level One", internal_name: "level_one", points: 10, picture_file_name: "finger.jpeg", picture_content_type: "image/jpeg", picture_file_size: 102707, picture_updated_at: "2018-01-30 22:47:59", description: {}, name: {"un"=>"Level One"}},
  {product_id: 6, name_text_old: "Bronze", internal_name: "bronze", points: 5, picture_file_name: "Triangle_-_Bronze.png", picture_content_type: "image/png", picture_file_size: 42633, picture_updated_at: "2018-02-05 19:44:57", description: {}, name: {"un"=>"Bronze"}},
  {product_id: 6, name_text_old: "Silver", internal_name: "silver", points: 20, picture_file_name: "Square_-_Silver.png", picture_content_type: "image/png", picture_file_size: 66934, picture_updated_at: "2018-02-05 19:45:34", description: {}, name: {"un"=>"Silver"}},
  {product_id: 6, name_text_old: "Gold", internal_name: "gold", points: 50, picture_file_name: "Pentagon_-_Gold.png", picture_content_type: "image/png", picture_file_size: 59004, picture_updated_at: "2018-02-05 19:45:58", description: {}, name: {"un"=>"Gold"}},
  {product_id: 6, name_text_old: "Platinum", internal_name: "platinum", points: 70, picture_file_name: "Hexagon_-_Platinum.png", picture_content_type: "image/png", picture_file_size: 61192, picture_updated_at: "2018-02-05 19:46:33", description: {}, name: {"un"=>"Platinum"}}
])
Merchandise.create!([
  {product_id: 7, name_text_old: "Test Item", description_text_old: "This is an item", price: "$45", purchase_url: "https://google.com", picture_file_name: "content-bg.jpeg", picture_content_type: "image/jpeg", picture_file_size: 343475, picture_updated_at: "2018-03-10 23:26:50", available: true, priority: 0, name: {"un"=>"Test Item"}, description: {"un"=>"This is an item"}},
  {product_id: 1, name_text_old: "NBC Merchandise", description_text_old: "", price: "", purchase_url: "", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, available: true, priority: 0, name: {"un"=>"NBC Merchandise"}, description: {}},
  {product_id: 7, name_text_old: "Test Item 2", description_text_old: "Another Test Item", price: "$600001.27", purchase_url: "https://www.nfl.com", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, available: true, priority: 0, name: {"un"=>"Test Item 2"}, description: {"un"=>"Another Test Item"}}
])
NotificationDeviceId.create!([
  {person_id: 114, device_identifier: "fnvGZjN4Y98:APA91bGt9YtS6KyLtjlacYHwZfCktgTceveHJuIFeyb6wtLbM2heXFp6immLMbZvQGYLrcYQHf-CRu_YMDTMl9jEPQbu2vOSe3UJCADEJGK_rTZswdkFW9QXb4g-TbrE-fu_fRsuZMc1"},
  {person_id: 69, device_identifier: "ePVCgYDjPLo:APA91bHLIFjRSLhhqbvAC329ypuOkIoWAM0JXr3Y52p-YpkmkHN94rBzAPfuC7VI4EFR7UBQRPKP4CDciq-gFGKzQw7xlNST-JcLffXpXijGxbReptzrjFYsr2zfr0BNLtoZaeJrNbDY"},
  {person_id: 22, device_identifier: "cOnFoy1YyCU:APA91bF_BFAZ7sPGP1nh83HqpPrz8KaAnD7iNHF7gk7RVSX2LyiJkcADXQbDel-U5vg88Zygt_fQiMypFUIKAm-ZmvWJ2bt3rC78K8AtL4TTi-6zmJlzVId-jsC4oH1k7N0NSrKr5nJZ"},
  {person_id: 31, device_identifier: "fDiQSZ4eISU:APA91bF5x_k1Aw2AG8SaUmjOtDtvrUcsu-fYhj5j651EM_cLeOO4Fot9GBpfVAuQm-CCB1vCxBLdtx74aBpEFjVn7jRIaDRyPwkQpk3YdfVUs9WwV8ueROHAErEbQKtFxPmYn_0Iqifs"},
  {person_id: 22, device_identifier: "fNKW5GWukqs:APA91bHS-rQfPWJwmDjV7DLV9Jbaba7pyw4_IF5D5rBOjQsnu9ollb0tWTA8XN9o12otAaF77RmmgBpWu85n5Gkb2g9u5qg-cB415Gh9wPnc5Fj71kCnuQ8sIQHIcDmMyy-MmqFrFRik"}
])
PostReport.create!([
  {post_id: 282, person_id: 32, reason: "I have no reason.", status: "post_hidden"},
  {post_id: 328, person_id: 22, reason: "ugly", status: "post_hidden"},
  {post_id: 327, person_id: 22, reason: "", status: "post_hidden"},
  {post_id: 335, person_id: 40, reason: "Pears are gross", status: "post_hidden"},
  {post_id: 91, person_id: 22, reason: "", status: "post_hidden"}
])
Product.create!([
  {name: "Admin", internal_name: "admin", enabled: false, can_have_supers: true},
  {name: "Test Product", internal_name: "test", enabled: false, can_have_supers: false},
  {name: "Test Product2", internal_name: "test2", enabled: false, can_have_supers: false}
])
RoomMembership.create!([
  {room_id: 3, person_id: 3, message_count: 0},
  {room_id: 4, person_id: 3, message_count: 0},
  {room_id: 4, person_id: 15, message_count: 0},
  {room_id: 12, person_id: 3, message_count: 0},
  {room_id: 12, person_id: 15, message_count: 0}
])
