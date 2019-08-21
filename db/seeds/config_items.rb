caned = Product.where(internal_name: 'caned').first

null = nil
ActsAsTenant.with_tenant(caned) do

  app_settings = RootConfigItem.create!(item_key:"app_settings", item_value: '', enabled: true )

  app_settings_items = {
    "product": "caned",
    "terms_url": "https://sierra-nevada-education.com/terms-of-use/",
    "support_email": "info@sierra-nevada-education.com",
    "privacy_url": "https://sierra-nevada-education.com/terms-of-use/",
    "has_onboarding": true,
    "has_age_verification": true,
    "has_sign_up": true,
    "has_fb_sign_in": true,
    "has_relationships": true,
    "has_badges": false,
    "has_interest": true,
    "has_categories": true,
  }
  app_settings_items.each do |item|
    if item.last.is_a?(TrueClass) || item.last.is_a?(FalseClass)
      ci = BooleanConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    else
      ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    end
    ci.move_to_child_of(app_settings)
  end

  tabs = RootConfigItem.create!(item_key:"tabs", item_value: '', enabled: true )
  tabs.move_to_child_of(app_settings)

  tab_items = {
    "first_tab": "certificates",
    "second_tab": "discover",
    "third_tab": "chat",
    "fourth_tab": "feed",
    "fifth_tab": "profile"
  }

  tab_items.each  do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(tabs)
  end

  reaction_items = %w(💚 🙏 👍 👎 😂 😃 🙁 💨 😍 🔥)
  #
  # reaction_items = %w(
  #   \\\uD83D\\\uDC9A
  #   \uD83D\uDE4F
  #   \uD83D\uDC4D
  #   \uD83D\uDC4E
  #   \uD83D\uDE02
  #   \uD83D\uDE03
  #   \uD83D\uDE41
  #   \uD83D\uDCA8
  #   \uD83D\uDE0D
  #   \uD83D\uDD25)

  reactions = ArrayConfigItem.create!(item_key:"reactions", item_value: '', enabled: true )
  reactions.move_to_child_of(app_settings)

  reaction_items.each  do |item|
    ci = StringConfigItem.create!( item_value: item.last, enabled: true )
    ci.move_to_child_of(reactions)
  end


  app_settings_colors = {
    "navigation_bar_background": "#4D4D4F",
    "navigation_bar_underline": "#XXXXXX",
    "navigation_bar_text": "#FFFFFF",
    "app_background": "#A7A9AC",
    "app_foreground": "#FFFFFF",
    "app_accent_foreground": "#994C8E",
    "app_text_main": "#FFFFFF",
    "app_text_secondary": "#000000",
    "button_main_background_enabled": "#994C8E",
    "button_main_background_disabled": "#cb7abe",
    "button_main_foreground_enabled": "#FFFFFF",
    "button_main_foreground_disabled": "#FFFFFF",
    "button_secondary_background_enabled": "#4D4D4F",
    "button_secondary_background_disabled": "#585858",
    "button_secondary_foreground_enabled": "#FFFFFF",
    "button_secondary_foreground_disabled": "#FFFFFF",
    "button_tertiary_background_enabled": "#FFFFFF",
    "button_tertiary_background_disabled": "#D3D3D3",
    "button_tertiary_foreground_enabled": "#000000",
    "button_tertiary_foreground_disabled": "#000000",
    "progress_fill": "#994C8E",
    "progress_empty": "#FFFFFF"
  }

  colors =  RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(app_settings)

  app_settings_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end



  certificates =  RootConfigItem.create!(item_key:"certificates", item_value: '', enabled: true )

  colors =  RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(certificates)

  certificates_colors = {
    "certificate_list_background": "#A7A9AC",
    "certificate_list_text": "#FFFFFF",
    "course_list_background": "#A7A9AC",
    "course_list_foreground": "#FFFFFF",
    "certificate_icon_inactive": "#FFFFFF",
    "certificate_icon_active": "#994C8E",
    "quiz_correct": "#417505",
    "quiz_incorrect": "#d0021b"
  }

  certificates_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end

  chat =  RootConfigItem.create!(item_key:"chat", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(chat)

  chat_colors = {
    "chat_background": "#A7A9AC",
    "chat_list_background_odd": "#33FFFFFF",
    "chat_list_background_even": "#A7A9AC",
    "chat_list_text": "#FFFFFF",
    "pinned_container_background": "#4D4D4F",
    "pinned_message_background": "#ffffff",
    "pinned_message_username": "#994C8E",
    "pinned_message_text": "#000000",
    "pinned_message_highlight": "#994C8E",
    "message_background": "#ffffff",
    "message_username": "#994C8E",
    "message_text": "#000000",
    "message_highlight": "#994C8E",
    "my_message_background": "#994C8E",
    "my_message_username": "#ffffff",
    "my_message_text": "#ffffff",
    "my_message_highlight": "#0099cc",
    "message_input_background": "#0099cc",
    "message_input_text": "#ffffff",
    "message_input_hint_text": "#aaaaaa",
    "message_input_highlight": "#994C8E",
    "chat_date_box_background": "#ffffff",
    "chat_date_box_text": "#000000"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end

  {
    "has_video_upload": true,
    "has_photo_upload": true
  }.each do |item|
    ci = BooleanConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(chat)
  end

  feeds =  RootConfigItem.create!(item_key:"feeds", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(feeds)

  chat_colors = {
    "post_background": "#ffffff",
    "post_foreground": "#000000",
    "post_text": "#000000",
    "post_highlighted_text": "#994C8E",
    "poll_background": "#4D4D4F",
    "poll_text": "#ffffff",
    "poll_option_text": "#000000",
    "poll_empty": "#ffffff",
    "poll_fill": "#7fcc0000",
    "reaction_counter_text": "#994C8E",
    "reaction_counter_container": "#994C8E"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end


  {
    "user_can_post": true,
    "has_video_posts": true,
    "has_audio_posts": true,
    "has_photo_posts": true,
    "has_polls_posts": true,
    "has_reactions": true,
    "has_share": true,
    "has_complete_profile_box": true,
    "has_comments": true
  }.each do |item|
    ci = BooleanConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(feeds)
  end


  profile =  RootConfigItem.create!(item_key:"profile", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(profile)

  chat_colors = {
    "profile_container_background": "#ffffff",
    "profile_container_text": "#000000",
    "profile_container_relationship_text": "#D10909"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end



  settings =  RootConfigItem.create!(item_key:"settings", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(settings)

  chat_colors = {
    "list_title_background": "#A7A9AC",
    "list_title_text": "#000000",
    "list_item_background": "#33FFFFFF",
    "list_item_text": "#000000",
    "list_item_separator": "#4D4D4F"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end

  trivia =  RootConfigItem.create!(item_key:"trivia", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(trivia)

  chat_colors = {
    "list_item_background": "#A7A9AC",
    "list_item_text_title": "#000000",
    "list_item_text_info": "#000000"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end



  discover =  RootConfigItem.create!(item_key:"discover", item_value: '', enabled: true )

  colors = RootConfigItem.create!(item_key:"colors", item_value: '', enabled: true )
  colors.move_to_child_of(trivia)

  chat_colors = {
    "container_background": "#ffffff",
    "container_foreground": "#000000",
    "container_text": "#000000",
    "container_highlighted_text": "#994C8E",
    "reaction_counter_text": "#994C8E",
    "reaction_counter_container": "#994C8E"
  }

  chat_colors.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(colors)
  end

  {
    "has_search_by_interests": true
  }.each do |item|
    ci = BooleanConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(discover)
  end


  onboarding_screens = ArrayConfigItem.create!(item_key: "onboarding_screens", item_value:'', enabled: true)

  welcome_items = {
    "title": "Welcome to Can-Ed",
    "short_description": "The number one cannabis education app that fits right in your pocket and provides quality cannabis education while you’re on the go.",
    "long_description": null,
    "image": "https://utlto/onboarding_1.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'', enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end


  welcome_items = {
    "title": "Certifications",
    "short_description": "The first step to earning your cannabis career certification is to sign-up for a course. Next, complete the modules, pass the quizzes, and voila! Certification earned. It’s that easy.",
    "long_description": null,
    "image": "https://utlto/onboarding_2.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end

  welcome_items = {
    "title": "Chat",
    "short_description": "Connect with fellow students and instructors. Discuss course material, ask questions, or discuss what’s on your mind. Just keep it course and cannabis related.",
    "long_description": null,
    "image": "https://utlto/onboarding_3.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end

  welcome_items = {
    "title": "Discover",
    "short_description": "Search and find. Select your interests and discover people on the app who like the same things as you do. You may be surprised by what you have in common.",
    "long_description": null,
    "image": "https://utlto/onboarding_4.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end

  welcome_items = {
    "title": "Feed",
    "short_description": "Stay in the know. Find out what’s happening in the cannabis industry, learn about job opportunities, and get in on the conversation with others in the Can-Ed community.",
    "long_description": null,
    "image": "https://utlto/onboarding_5.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end

  welcome_items = {
    "title": "Profile",
    "short_description": "Getting to know you. Create a custom profile by adding a picture, a bio, and selecting your interests.",
    "long_description": null,
    "image": "https://utlto/onboarding_6.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end
  welcome_items = {
    "title": "Support",
    "short_description": "Chat with our support team through the private chat message that will be saved on your chat tab. We are available Monday-Friday 8am - 3pm PST but you can send us a message any time.",
    "long_description": null,
    "image": "https://utlto/onboarding_7.png",
    "bg_start_color": "#555454",
    "bg_end_color": "#2b2a2a",
    "fg_color": "#ffffff"
  }
  welcome = RootConfigItem.create!(item_key: "", item_value:'',enabled: true)
  welcome.move_to_child_of(onboarding_screens)
  welcome_items.each do |item|
    ci = StringConfigItem.create!(item_key:item.first, item_value: item.last, enabled: true )
    ci.move_to_child_of(welcome)
  end
end
