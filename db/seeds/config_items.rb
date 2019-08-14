caned = Product.where(internal_name: 'caned').first

ActsAsTenant.with_tenant(caned) do
  # onboardingScreens = ConfigItem.create(item_key:"onboardingScreens", item_value: '', enabled: true )
  # onboardingScreens_items  =  { title: "text",
  #             short_description: "text",
  #             long_description: "text",
  #             image: "image_name",
  #             bg_start_color: "#ffffff",
  #             bg_end_color: "#000000",
  #             fg_color: "#AAAAAA"}
  #
  # onboardingScreens_items.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(onboardingScreens)
  # end
  #
  #
  # app_settings = ConfigItem.create(item_key:"app_settings", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(app_settings)
  #
  # app_settings_colors = {navigation_bar_background: "#FFUU00",
  #                        navigation_bar_underline: "#FFUU00",
  #                        navigation_bar_text: "#FFUU00",
  #                        app_background: "#aaddee",
  #                        app_foreground: "#ddadad",
  #                        app_accent_foreground: "#eeaaff",
  #                        app_text_light: "#ddee00",
  #                        app_text_dark: "#ddee00",
  #                        button_main_background_enabled: "#eeddff",
  #                        button_main_background_disabled: "#eeddff",
  #                        button_main_foregorund_enabled: "#eeddff",
  #                        button_main_foregorund_disabled: "#eeddff",
  #                        button_dark_background_enabled: "#eeddff",
  #                        button_dark_background_disabled: "#eeddff",
  #                        button_dark_foregorund_enabled: "#eeddff",
  #                        button_dark_foregorund_disabled: "#eeddff",
  #                        button_light_background_enabled: "#eeddff",
  #                        button_light_background_disabled: "#eeddff",
  #                        button_light_foregorund_enabled: "#eeddff",
  #                        button_light_foregorund_disabled: "#eeddff",
  #                        progress_fill: "#eeeeee",
  #                        progress_empty: "#eeeeee"}
  #
  # app_settings_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  #
  # app_settings_items = {
  #   product: "caned",
  #   terms_url: "https://sierra-nevada-education.com/terms-of-use/",
  #   support_email: "info@sierra-nevada-education.com",
  #   privacy_url: "https://sierra-nevada-education.com/terms-of-use/",
  #   has_onboarding: false,
  #   has_age_verification: true,
  #   has_sign_up: true,
  #   has_fb_sign_in: true,
  #   has_relationships: true,
  #   has_badges: false,
  #   has_interest: true,
  #   has_categories: true,
  #   tabs: ["certificates",
  #          "chat",
  #          "discover",
  #          "feed",
  #          "profile",
  #          "product",
  #          "events",
  #          "trivia"],
  # }
  #
  # app_settings_items.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(app_settings)
  # end
  #
  #
  #
  # certificates = ConfigItem.create(item_key:"certificates", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(certificates)
  #
  # certificates_colors = {certificate_list_background: "#ddeeaa",
  #                  certificate_list_text: "#FFUU00",
  #                  course_list_background: "#eeddaa",
  #                  course_list_text: "#ffaaee",
  #                  certificate_icon_inactive: "#eeeeee",
  #                  certificate_icon_active: "#eeeeee",
  #                  quiz_correct_text: "#aadddd",
  #                  quiz_incorrect_text: "#aadddd"}
  #
  # certificates_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  # chat = ConfigItem.create(item_key:"feed", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(chat)
  #
  # settings_colors = {chat_background: "#eeeeee",
  #                    chat_secondary_background: "#eeeeee",
  #                    chat_list_text: "#eeeeee",
  #                    pinned_container_background: "#eeeeee",
  #                    pinned_message_text: "#FFUU00",
  #                    pinned_message_background: "#FFUU00",
  #                    message_background: "#eeeeee",
  #                    message_text: "#FFUU00",
  #                    my_message_background: "#eeeeee",
  #                    my_message_text: "#FFUU00",
  #                    message_input_background: "#eeeeee",
  #                    message_input_text: "#eeeeee",
  #                    message_input_hint_text: "#eeeeee",
  #                    chat_date_box_background: "#eeeeee",
  #                    chat_date_box_text: "#eeeeee"}
  #
  # settings_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  # chat_items = {has_video_upload: true,
  #               has_photo_upload: true}
  #
  # chat_items.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(chat)
  # end
  #
  # feed = ConfigItem.create(item_key:"feed", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(feed)
  #
  # settings_colors = {post_background: "#eeeeee",
  #                    post_foregorund: "#eeeeee",
  #                    post_text: "#eeeeee",
  #                    poll_background: "#eeeeee",
  #                    poll_text: "#eeeeee",
  #                    poll_empty: "#ffffff",
  #                    poll_fill: "#eeeeee",
  #                    reaction_counter_text: "#eeeeee"}
  #
  # settings_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  # feed_items = {user_can_post: true,
  #  has_video_posts: true,
  #  has_audio_posts: true,
  #  has_photo_posts: true,
  #  has_polls_posts: true,
  #  has_reactions: true,
  #  has_share: true,
  #  has_complete_profile_box: true,
  #  has_comments: true}
  #
  # feed_items.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(feed)
  # end
  #
  # profile = ConfigItem.create(item_key:"profile", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(profile)
  #
  # settings_colors = {profile_container_background: "#dddddd",
  #                    profile_container_text: "#dddddd",
  #                    profile_container_relationship_text: "#dddddd"}
  #
  # settings_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  # settings = ConfigItem.create(item_key:"settings", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(settings)
  #
  # settings_colors = {list_title_background: "#dddddd",
  #                  list_title_text: "#dddddd",
  #                  list_item_background: "#dddddd",
  #                  list_item_text: "#dddddd",
  #                  list_item_separator: "#dddddd"}
  #
  # settings_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  #
  #
  # trivia = ConfigItem.create(item_key:"trivia", item_value: '', enabled: true )
  #
  # colors = ConfigItem.create(item_key:"colors", item_value: '', enabled: true )
  # colors.move_to_child_of(trivia)
  #
  # trivia_colors = {list_item_background: "#dddddd",
  #                  list_item_text_title: "#dddddd",
  #                  list_item_text_info: "#dddddd"}
  #
  # trivia_colors.each do |item|
  #   ci = ConfigItem.create(item_key:item.first, item_value: item.last, enabled: true )
  #   ci.move_to_child_of(colors)
  # end
  #
  # ConfigItem.create(item_key:"discover", item_value: '', enabled: true )
  # ConfigItem.create(item_key:"censoredWords", item_value: '', enabled: true )

end
