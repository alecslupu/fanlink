caned = Product.where(internal_name: 'caned').first

ActsAsTenant.with_tenant(caned) do

  ConfigItem.create!(item_key: 'has_onboarding', item_value: 'false', enabled: true)
  ConfigItem.create!(item_key: 'has_sign_up', item_value: 'true', enabled: true)
  ConfigItem.create!(item_key: 'has_fb_sign_in', item_value: 'true', enabled: true)
  ConfigItem.create!(item_key: 'has_relationships', item_value: 'true', enabled: true)
  ConfigItem.create!(item_key: 'has_badges', item_value: 'false', enabled: true)
  ConfigItem.create!(item_key: 'has_interest', item_value: 'true', enabled: true)
  ConfigItem.create!(item_key: 'has_categories', item_value: 'true', enabled: true)


  # ConfigItem.create!(item_key: 'navigation_bar_background', item_value: "#FFUU00", enabled: true)
  # ConfigItem.create!(item_key: 'navigation_bar_underline', item_value: "#FFUU00", enabled: true)
  ConfigItem.create!(item_key: 'navigation_bar_text', item_value: "#FFUU00", enabled: true)
  ConfigItem.create!(item_key: 'app_background', item_value: '#aaddee', enabled: true)
  ConfigItem.create!(item_key: 'app_foreground', item_value: '#ddadad', enabled: true)
  ConfigItem.create!(item_key: 'app_accent_foreground', item_value: '#eeaaff', enabled: true)



  ConfigItem.create!(item_key: 'app_text_light', item_value: '#ddee00', enabled: true)
  ConfigItem.create!(item_key: 'app_text_dark', item_value: '#ddee00', enabled: true)

  ConfigItem.create!(item_key: 'button_main_background_enabled', item_value: '#eeddff', enabled: true)
  ConfigItem.create!(item_key: 'button_main_background_disabled', item_value: '#eeddff', enabled: true)
  ConfigItem.create!(item_key: 'button_main_foregorund_enabled', item_value: '#eeddff', enabled: true)
  ConfigItem.create!(item_key: 'button_main_foregorund_disabled', item_value: '#eeddff', enabled: true)
  ConfigItem.create!(item_key: 'button_main_background_enabled', item_value: '#eeddff', enabled: true)






=begin
{

"": "#", // default color for light text
"": "#", // default color for dark text
"button_main_background_enabled": "#", // default color for main button background
"": "#eeddff", // default color for main button background when disabled or pressed
"": "#eeddff", // default color for main button text/icons
"": "#eeddff", // default color for main button text/icons
"button_dark_background_enabled": "#eeddff", // default color for dark button background
"button_dark_background_disabled": "#eeddff", // default color for dark button background when disabled or pressed
"button_dark_foregorund_enabled": "#eeddff", // default color for dark button text/icons
"button_dark_foregorund_disabled": "#eeddff", // default color for dark button text/icons
"button_light_background_enabled": "#eeddff", // default color for dark button background
"button_light_background_disabled": "#eeddff", // default color for dark button background when disabled or pressed
"button_light_foregorund_enabled": "#eeddff", // default color for dark button text/icons
"button_light_foregorund_disabled": "#eeddff", // default color for dark button text/icons
"progress_fill": "#eeeeee", // default progress-bar fill color
"progress_empty": "#eeeeee" // default progress-bar empty color
    }
  },
  "certificates": {
    "colors": {
      "certificate_list_background": "#ddeeaa",
      "certificate_list_text": "#FFUU00",
      "course_list_background": "#eeddaa",
      "course_list_text": "#ffaaee",
      "certificate_icon_inactive": "#eeeeee",
      "certificate_icon_active": "#eeeeee",
      "quiz_correct_text": "#aadddd",
      "quiz_incorrect_text": "#aadddd"
    }
  },
  "chat": {
    "colors": {
      "chat_background": "#eeeeee",
      "chat_secondary_background": "#eeeeee",
      "chat_list_text": "#eeeeee",
      "pinned_container_background": "#eeeeee",
      "pinned_message_text": "#FFUU00",
      "pinned_message_background": "#FFUU00",
      "message_background": "#eeeeee",
      "message_text": "#FFUU00",
      "my_message_background": "#eeeeee",
      "my_message_text": "#FFUU00",
      "message_input_background": "#eeeeee",
      "message_input_text": "#eeeeee",
      "message_input_hint_text": "#eeeeee",
      "chat_date_box_background": "#eeeeee",
      "chat_date_box_text": "#eeeeee"
    },
    "has_video_upload": true,
    "has_photo_upload": true
  },
  "feed": {
    "colors": {
      "post_background": "#eeeeee",
      "post_foregorund": "#eeeeee",
      "post_text": "#eeeeee",
      "poll_background": "#eeeeee",
      "poll_text": "#eeeeee",
      "poll_empty": "#ffffff",
      "poll_fill": "#eeeeee",
      "reaction_counter_text": "#eeeeee"
    },
    "user_can_post": true,
    "has_video_posts": true,
    "has_audio_posts": true,
    "has_photo_posts": true,
    "has_polls_posts": true,
    "has_reactions": true,
    "has_share": true,
    "has_complete_profile_box": true,
    "has_comments": true,
  },
  "profile": {
    "colors": {
      "profile_container_background": "#dddddd",
      "profile_container_text": "#dddddd",
      "profile_container_relationship_text": "#dddddd"
    }
  },
  "settings": {
    "colors": {
      "list_title_background": "#dddddd",
      "list_title_text": "#dddddd",
      "list_item_background": "#dddddd",
      "list_item_text": "#dddddd",
      "list_item_separator": "#dddddd"
    }
  },
  "onboarding_screens": [
    {
      "title": "text", // Screen title
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     "short_description": "text", // Short description
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     "long_description": "text", // Long description which will be displayed on More press. This field is nullable. If it's null More button should not be displayed
      "image": "image_name", // Image name. No path, no extension, just the image name.
      "bg_start_color": "#ffffff", // Background gradient start color
      "bg_end_color": "#000000", // Background gradient end color. If same as start color then there will be no gradient
      "fg_color": "#AAAAAA" // Foreground color - text, icons if any, progress bubbles color
    },
    ...
  ],
  "censored_words": [
    "word",
    "word",
    ...
  ],
  "discover": {},
  "feed": {},
  "profile": {}
}
=end

end
