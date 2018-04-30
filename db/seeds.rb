# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Product.count == 0
  Product.create(name: "Admin", internal_name: "admin", can_have_supers: true)
  unless Rails.env.production?
    Product.create(name: "Test Product", internal_name: "test")
  end
end

if Person.count == 0
  unless Rails.env.production?
    Person.create(name: "Admin User", username: "admin", product_id: Product.find_by(internal_name: "admin").id, email: "admin@example.com", password: "flink_admin", role: :super_admin)

    Person.create(name: "Test Admin", username: "test_admin", product_id: Product.find_by(internal_name: "test").id, email: "test_admin@example.com", password: "password", role: :admin)

    Person.create(name: "Test Staff", username: "test_staff", product_id: Product.find_by(internal_name: "test").id, email: "test_staff@example.com", password: "password", role: :staff)


    4.upto 50 do |n|
      unless (Person.where(id: n)).exists?
        Person.create(name: "Test User #{n}", username: "test_user#{n}", product_id: Product.find_by(internal_name: "test").id, email: "somebody#{n}@example.com", password: "password")
      end
    end
  end
end

if Room.count < 10
  unless Rails.env.production?
    prod = Product.find_by(internal_name: "test").try(:id)
    u = Person.find_by(name: "Admin User").try(:id)
    if prod && u
      1.upto 10 do |n|
        unless (Room.where(id: n)).exists?
          Room.create(name: "Public room #{n}", created_by_id: u, public: true, product_id: prod, status: :active)
        end
      end
    end
  end
end

if ActionType.count == 0
  unless Rails.env.production?
    ActionType.create!([
      {name: "Follow Person", internal_name: "follow_person", seconds_lag: 0, active: true},
      {name: "Open App Daily", internal_name: "open_app_daily", seconds_lag: 86400, active: true},
      {name: "Chat 10 Minutes Daily", internal_name: "chat_10_daily", seconds_lag: 86400, active: true},
      {name: "Chat 30 Minutes Daily", internal_name: "chat_30_daily", seconds_lag: 86400, active: true},
      {name: "Chat 60 Minutes Daily", internal_name: "chat_60_daily", seconds_lag: 86400, active: true},
      {name: "React to 250 posts", internal_name: "react_250_posts", seconds_lag: 86400, active: true}
    ])
  end
end

if Following.count == 0
  unless Rails.env.production?
    Following.create!([
      {follower_id: 6, followed_id: 17},
      {follower_id: 17, followed_id: 6},
      {follower_id: 21, followed_id: 6},
      {follower_id: 22, followed_id: 6},
      {follower_id: 23, followed_id: 6}
    ])
  end
end

if Level.count == 0
  unless Rails.env.production?
    Level.create!([
      {product_id: 2, name_text_old: "Newbie", internal_name: "claiente", points: 250, picture_file_name: "inna-status-01.png", picture_content_type: "image/png", picture_file_size: 35412, picture_updated_at: "2018-03-30 18:20:18", description: {}, name: {"un"=>"Caliente"}},
      {product_id: 2, name_text_old: "Fan", internal_name: "hot", points: 1000, picture_file_name: "inna-status-02.png", picture_content_type: "image/png", picture_file_size: 24965, picture_updated_at: "2018-03-30 18:20:48", description: {}, name: {"un"=>"Hot"}},
      {product_id: 1, name_text_old: "Newbie", internal_name: "newbie", points: 250, picture_file_name: "Amber_(alt).png", picture_content_type: "image/png", picture_file_size: 37554, picture_updated_at: "2018-03-07 05:12:14", description: {}, name: {"un"=>"Newbie"}},
      {product_id: 1, name_text_old: "Fan", internal_name: "fan", points: 1000, picture_file_name: "Turqoise.png", picture_content_type: "image/png", picture_file_size: 53002, picture_updated_at: "2018-03-07 05:12:29", description: {}, name: {"un"=>"Fan"}},
      {product_id: 1, name_text_old: "Super Fan", internal_name: "super_fan", points: 2500, picture_file_name: "Amethyst.png", picture_content_type: "image/png", picture_file_size: 80473, picture_updated_at: "2018-03-07 05:12:50", description: {}, name: {"un"=>"Super Fan"}}
    ])
  end
end


if Post.count == 0
  unless Rails.env.production?
    Post.create!([
      {person_id: 3, body_text_old: "Hi", global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "deleted", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {"en"=>"Hi", "es"=>"Hi", "ro"=>"Hi", "un"=>"Hi"}, priority: 0, recommended: false},

      {person_id: 7, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "published", picture_file_name: nil, picture_content_type: nil, picture_file_size: nil, picture_updated_at: nil, body: {"un"=>"Smiley rocks! "}, priority: 0, recommended: false},
      
      {person_id: 28, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "deleted", picture_file_name: "image.jpg", picture_content_type: "image/jpeg", picture_file_size: 2980321, picture_updated_at: "2018-03-07 21:17:27", body: {"un"=>"hello!"}, priority: 0, recommended: false},
      
      {person_id: 18, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "published", picture_file_name: "image.jpg", picture_content_type: "image/jpeg", picture_file_size: 86869, picture_updated_at: "2018-03-07 05:02:17", body: {"un"=>"Hei"}, priority: 0, recommended: false},
      
      {person_id: 25, body_text_old: nil, global: false, starts_at: nil, ends_at: nil, repost_interval: 0, status: "published", picture_file_name: "image.jpg", picture_content_type: "image/jpeg", picture_file_size: 906451, picture_updated_at: "2018-03-08 16:22:31", body: {"un"=>"I wonder if Smiley has been to Africa..or enjoys History.. Do any of my friends know? "}, priority: 0, recommended: false}
    ])
  end
end

if PostReaction.count == 0
  unless Rails.env.production?
    PostReaction.create!([
      {post_id: 1, person_id: 6, reaction: "1F606"},
      {post_id: 2, person_id: 8, reaction: "1F621"},
      {post_id: 2, person_id: 13, reaction: "1F600"},
      {post_id: 3, person_id: 19, reaction: "1F600"},
      {post_id: 4, person_id: 23, reaction: "1F44D"}
    ])
  end
end

if Relationship.count == 0
  unless Rails.env.production?
    Relationship.create!([
      {requested_by_id: 6, requested_to_id: 21, status: "requested"},
      {requested_by_id: 15, requested_to_id: 23, status: "friended"},
      {requested_by_id: 8, requested_to_id: 20, status: "friended"},
      {requested_by_id: 19, requested_to_id: 20, status: "friended"},
      {requested_by_id: 44, requested_to_id: 21, status: "requested"}
    ])
  end
end

if Badge.count == 0
  unless Rails.env.production?
    Badge.create!([
      {product_id: 1, name_text_old: nil, internal_name: "react_250_posts", action_type_id: 6, action_requirement: 250, point_value: 500, picture_file_name: "react_250.png", picture_content_type: "image/png", picture_file_size: 19170, picture_updated_at: "2018-03-25 18:49:00", description_text_old: nil, name: {"un"=>"React to your favorite 250 posts"}, description: {"un"=>"React to your favorite 250 posts"}, issued_from: nil, issued_to: nil},

      {product_id: 1, name_text_old: "Active for 90 Days", internal_name: "daily_activity_90", action_type_id: 2, action_requirement: 90, point_value: 500, picture_file_name: "inna_active-90.png", picture_content_type: "image/png", picture_file_size: 9773, picture_updated_at: "2018-03-30 18:28:05", description_text_old: "Open the app once every day for 90 days.", name: {"un"=>"Active for 90 Days"}, description: {"un"=>"Open the app once every day for 90 days."}, issued_from: nil, issued_to: nil},
      
      {product_id: 1, name_text_old: "Follow 10 People", internal_name: "follow_10", action_type_id: 1, action_requirement: 10, point_value: 25, picture_file_name: "inna_follow-10.png", picture_content_type: "image/png", picture_file_size: 18275, picture_updated_at: "2018-03-30 18:24:09", description_text_old: "To follow a user, visit and tap the \"Follow\" icon.", name: {"un"=>"Follow 10 People"}, description: {"un"=>"To follow a user, visit and tap the \"Follow\" icon."}, issued_from: nil, issued_to: nil},
      
      {product_id: 1, name_text_old: "Follow 50 People", internal_name: "follow_50", action_type_id: 1, action_requirement: 50, point_value: 100, picture_file_name: "inna_follow-25.png", picture_content_type: "image/png", picture_file_size: 18748, picture_updated_at: "2018-03-30 18:25:43", description_text_old: "To follow a user, visit and tap the \"Follow\" icon.", name: {"un"=>"Follow 50 People"}, description: {"un"=>"To follow a user, visit and tap the \"Follow\" icon."}, issued_from: nil, issued_to: nil},
      
      {product_id: 1, name_text_old: "Follow 200 People", internal_name: "follow_200", action_type_id: 1, action_requirement: 200, point_value: 250, picture_file_name: "inna_follow-100.png", picture_content_type: "image/png", picture_file_size: 18408, picture_updated_at: "2018-03-30 18:25:57", description_text_old: "To follow a user, visit and tap the \"Follow\" icon.", name: {"un"=>"Follow 200 People"}, description: {"un"=>"To follow a user, visit and tap the \"Follow\" icon."}, issued_from: nil, issued_to: nil}
    ])
  end
end

if BadgeAction.count == 0
  unless Rails.env.production?
    BadgeAction.create!([
      {action_type_id: 2, person_id: 6, identifier: nil},
      {action_type_id: 2, person_id: 7, identifier: nil},
      {action_type_id: 2, person_id: 9, identifier: nil},
      {action_type_id: 2, person_id: 11, identifier: nil},
      {action_type_id: 2, person_id: 14, identifier: nil}
    ])
  end
end