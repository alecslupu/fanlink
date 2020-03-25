
# 151
root = RootConfigItem.create!(item_key: "app_settings", item_value: "",  enabled: true)
child152 = StringConfigItem.create!(item_key: "product", item_value: "caned", enabled: true)
child152.move_to_child_of(root)

child153 = StringConfigItem.create!(item_key: "terms_url", item_value: "https://sierra-nevada-education.com/terms-of-use/", enabled: true)
child153.move_to_child_of(root)

child154 = StringConfigItem.create!(item_key: "support_email", item_value: "info@sierra-nevada-education.com", enabled: true)
child154.move_to_child_of(root)

child155 = StringConfigItem.create!(item_key: "privacy_url", item_value: "https://sierra-nevada-education.com/terms-of-use/", enabled: true)
child155.move_to_child_of(root)

child157 = BooleanConfigItem.create!(item_key: "has_sign_up", item_value: true, enabled: true)
child157.move_to_child_of(root)

child159 = BooleanConfigItem.create!(item_key: "has_fb_sign_in", item_value: true, enabled: true)
child159.move_to_child_of(root)

child430 = BooleanConfigItem.create!(item_key: "has_user_follow", item_value: true, enabled: true)
child430.move_to_child_of(root)

child431 = BooleanConfigItem.create!(item_key: "has_user_friend", item_value: true, enabled: true)
child431.move_to_child_of(root)

child161 = BooleanConfigItem.create!(item_key: "has_badges", item_value: false, enabled: true)
child161.move_to_child_of(root)

child432 = BooleanConfigItem.create!(item_key: "has_sbi", item_value: true, enabled: true)
child432.move_to_child_of(root)

child162 = BooleanConfigItem.create!(item_key: "has_comments", item_value: true, enabled: true)
child162.move_to_child_of(root)

child433 = BooleanConfigItem.create!(item_key: "has_invite_share", item_value: false, enabled: true)
child433.move_to_child_of(root)

child434 = BooleanConfigItem.create!(item_key: "has_user_post", item_value: true, enabled: true)
child434.move_to_child_of(root)

child435 = BooleanConfigItem.create!(item_key: "has_admin_post", item_value: true, enabled: true)
child435.move_to_child_of(root)

child397 = BooleanConfigItem.create!(item_key: "has_private_chat", item_value: true, enabled: true)
child397.move_to_child_of(root)

child436 = BooleanConfigItem.create!(item_key: "has_media_post", item_value: true, enabled: true)
child436.move_to_child_of(root)

# added
child1000 = BooleanConfigItem.create!(item_key: "has_recommended_posts", item_value: true, enabled: true)
child1000.move_to_child_of(root)

child1001 = BooleanConfigItem.create!(item_key: "has_recommended_people", item_value: true, enabled: true)
child1001.move_to_child_of(root)

child1002 = BooleanConfigItem.create!(item_key: "has_private_chat", item_value: true, enabled: true)
child1002.move_to_child_of(root)

child1004 = BooleanConfigItem.create!(item_key: "has_media_post", item_value: true, enabled: true)
child1004.move_to_child_of(root)

child1005 = BooleanConfigItem.create!(item_key: "has_courses_on_web", item_value: true, enabled: true)
child1005.move_to_child_of(root)

child1006 = BooleanConfigItem.create!(item_key: "has_customer_support_chat", item_value: true, enabled: true)
child1006.move_to_child_of(root)

child1007 = BooleanConfigItem.create!(item_key: "has_chat_with_instructor", item_value: true, enabled: true)
child1007.move_to_child_of(root)




child164 = RootConfigItem.create!(item_key: "tabs", item_value: "", enabled: true)
child164.move_to_child_of(root)

child387 = RootConfigItem.create!(item_key: "first_tab", item_value: "", enabled: true)
child387.move_to_child_of(child164)
child165 = StringConfigItem.create!(item_key: "tab_id", item_value: "education", enabled: true)
child165.move_to_child_of(child387)
child388 = StringConfigItem.create!(item_key: "tab_name", item_value: "Certificates", enabled: true)
child388.move_to_child_of(child387)

child389 = RootConfigItem.create!(item_key: "second_tab", item_value: "", enabled: true)
child389.move_to_child_of(child164)
child166 = StringConfigItem.create!(item_key: "tab_id", item_value: "discover", enabled: true)
child166.move_to_child_of(child389)
child390 = StringConfigItem.create!(item_key: "tab_name", item_value: "Discover", enabled: true)
child390.move_to_child_of(child389)

child391 = RootConfigItem.create!(item_key: "third_tab", item_value: "", enabled: true)
child391.move_to_child_of(child164)
child167 = StringConfigItem.create!(item_key: "tab_id", item_value: "chat", enabled: true)
child167.move_to_child_of(child391)
child392 = StringConfigItem.create!(item_key: "tab_name", item_value: "Chat", enabled: true)
child392.move_to_child_of(child391)

child393 = RootConfigItem.create!(item_key: "fourth_tab", item_value: "", enabled: true)
child393.move_to_child_of(child164)
child168 = StringConfigItem.create!(item_key: "tab_id", item_value: "feed", enabled: true)
child168.move_to_child_of(child393)
child392 = StringConfigItem.create!(item_key: "tab_name", item_value: "Feed", enabled: true)
child392.move_to_child_of(child393)

child395 = RootConfigItem.create!(item_key: "fifth_tab", item_value: "", enabled: true)
child395.move_to_child_of(child164)
child169 = StringConfigItem.create!(item_key: "tab_id", item_value: "profile", enabled: true)
child169.move_to_child_of(child395)
child396 = StringConfigItem.create!(item_key: "tab_name", item_value: "Profile", enabled: true)
child396.move_to_child_of(child395)

child170 = ArrayConfigItem.create!(id: 170, item_key: "reactions", item_value: "", enabled: true)
child170.move_to_child_of(root)

child171 = StringConfigItem.create!(item_key: "", item_value: "ðŸ’š", enabled: true)
child171.move_to_child_of(child170)

child172 = StringConfigItem.create!(item_key: "", item_value: "ðŸ™", enabled: true)
child172.move_to_child_of(child170)

child173 = StringConfigItem.create!(item_key: "", item_value: "ðŸ‘", enabled: true)
child173.move_to_child_of(child170)

child174 = StringConfigItem.create!(item_key: "", item_value: "ðŸ‘Ž", enabled: true)
child174.move_to_child_of(child170)

child175 = StringConfigItem.create!(item_key: "", item_value: "ðŸ˜‚", enabled: true)
child175.move_to_child_of(child170)

child176 = StringConfigItem.create!(item_key: "", item_value: "ðŸ˜ƒ", enabled: true)
child176.move_to_child_of(child170)

child177 = StringConfigItem.create!(item_key: "", item_value: "ðŸ™", enabled: true)
child177.move_to_child_of(child170)

child178 = StringConfigItem.create!(item_key: "", item_value: "ðŸ’¨", enabled: true)
child178.move_to_child_of(child170)

child179 = StringConfigItem.create!(item_key: "", item_value: "ðŸ˜", enabled: true)
child179.move_to_child_of(child170)

child178 = StringConfigItem.create!(item_key: "", item_value: "ðŸ”¥", enabled: true)
child178.move_to_child_of(child170)

child181 = RootConfigItem.create!(item_key: "colors", item_value: "", enabled: true)
child181.move_to_child_of(root)

child182 = StringConfigItem.create!(item_key: "navigation_bar_background", item_value: "#292828", enabled: true)
child182.move_to_child_of(child181)

child183 = StringConfigItem.create!(item_key: "navigation_bar_underline", item_value: "#994C8E", enabled: true)
child183.move_to_child_of(child181)

child184 = StringConfigItem.create!(item_key: "navigation_bar_foreground", item_value: "#FFFFFF", enabled: true)
child184.move_to_child_of(child181)

child185 = StringConfigItem.create!(item_key: "app_background_top", item_value: "#A7A9AC", enabled: true)
child185.move_to_child_of(child181)

child348 = StringConfigItem.create!(item_key: "app_background_bottom", item_value: "#A7A9AC", enabled: true)
child348.move_to_child_of(child181)

child186 = StringConfigItem.create!(item_key: "app_foreground", item_value: "#FFFFFF", enabled: true)
child186.move_to_child_of(child181)

child187 = StringConfigItem.create!(item_key: "app_accent", item_value: "#994C8E", enabled: true)
child187.move_to_child_of(child181)

child188 = StringConfigItem.create!(item_key: "app_text_main", item_value: "#FFFFFF", enabled: true)
child188.move_to_child_of(child181)

child189 = StringConfigItem.create!(item_key: "app_text_secondary", item_value: "#000000", enabled: true)
child189.move_to_child_of(child181)

child369 = StringConfigItem.create!(item_key: "app_text_input_hint", item_value: "#aaaaaa", enabled: true)
child369.move_to_child_of(child181)

child190 = StringConfigItem.create!(item_key: "button_main_background_enabled", item_value: "#994C8E", enabled: true)
child190.move_to_child_of(child181)

child191 = StringConfigItem.create!(item_key: "button_main_background_disabled", item_value: "#cb7abe", enabled: true)
child191.move_to_child_of(child181)

child192 = StringConfigItem.create!(item_key: "button_main_foreground_enabled", item_value: "#FFFFFF", enabled: true)
child192.move_to_child_of(child181)

child193 = StringConfigItem.create!(item_key: "button_main_foreground_disabled", item_value: "#FFFFFF", enabled: true)
child193.move_to_child_of(child181)

child194 = StringConfigItem.create!(item_key: "button_secondary_background_enabled", item_value: "#A7A9AC", enabled: true)
child194.move_to_child_of(child181)

child195 = StringConfigItem.create!(item_key: "button_secondary_background_disabled", item_value: "#585858", enabled: true)
child195.move_to_child_of(child181)

child196 = StringConfigItem.create!(item_key: "button_secondary_foreground_enabled", item_value: "#FFFFFF", enabled: true)
child196.move_to_child_of(child181)

child197 = StringConfigItem.create!(item_key: "button_secondary_foreground_disabled", item_value: "#FFFFFF", enabled: true)
child197.move_to_child_of(child181)

child198 = StringConfigItem.create!(item_key: "button_tertiary_background_enabled", item_value: "#292828", enabled: true)
child198.move_to_child_of(child181)

child199 = StringConfigItem.create!(item_key: "button_tertiary_background_disabled", item_value: "#D3D3D3", enabled: true)
child199.move_to_child_of(child181)

child200 = StringConfigItem.create!(item_key: "button_tertiary_foreground_enabled", item_value: "#FFFFFF", enabled: true)
child200.move_to_child_of(child181)

child201 = StringConfigItem.create!(item_key: "button_tertiary_foreground_disabled", item_value: "#000000", enabled: true)
child201.move_to_child_of(child181)

child384 = StringConfigItem.create!(item_key: "button_selection_main_checked_background", item_value: "#994C8E", enabled: true)
child384.move_to_child_of(child181)

child385 = StringConfigItem.create!(item_key: "button_selection_main_foreground", item_value: "#FFFFFF", enabled: true)
child385.move_to_child_of(child181)

child202 = StringConfigItem.create!(item_key: "progress_fill", item_value: "#994C8E", enabled: true)
child202.move_to_child_of(child181)

child203 = StringConfigItem.create!(item_key: "progress_empty", item_value: "#FFFFFF", enabled: true)
child203.move_to_child_of(child181)

child370 = StringConfigItem.create!(item_key: "app_list_background", item_value: "#A7A9AC", enabled: true)
child370.move_to_child_of(child181)

child371 = StringConfigItem.create!(item_key: "app_list_item_odd", item_value: "#B9BABD", enabled: true)
child371.move_to_child_of(child181)

child372 = StringConfigItem.create!(item_key: "app_list_item_even", item_value: "#A7A9AC", enabled: true)
child372.move_to_child_of(child181)

child373 = StringConfigItem.create!(item_key: "app_list_text", item_value: "#FFFFFF", enabled: true)
child373.move_to_child_of(child181)

child378 = StringConfigItem.create!(item_key: "app_list_separator", item_value: "#FFFFFF", enabled: true)
child378.move_to_child_of(child181)

child225 = StringConfigItem.create!(item_key: "message_background", item_value: "#ffffff", enabled: true)
child225.move_to_child_of(child181)

child226 = StringConfigItem.create!(item_key: "message_username", item_value: "#994C8E", enabled: true)
child226.move_to_child_of(child181)

child227 = StringConfigItem.create!(item_key: "message_text", item_value: "#000000", enabled: true)
child227.move_to_child_of(child181)

child379 = StringConfigItem.create!(item_key: "message_highlight", item_value: "#994C8E", enabled: true)
child379.move_to_child_of(child181)

child229 = StringConfigItem.create!(item_key: "my_message_background", item_value: "#984C8E", enabled: true)
child229.move_to_child_of(child181)

child230 = StringConfigItem.create!(item_key: "my_message_username", item_value: "#ffffff", enabled: true)
child230.move_to_child_of(child181)

child231 = StringConfigItem.create!(item_key: "my_message_text", item_value: "#FFFFFF", enabled: true)
child231.move_to_child_of(child181)

child232 = StringConfigItem.create!(item_key: "my_message_highlight", item_value: "#FFFFFF", enabled: true)
child232.move_to_child_of(child181)

child380 = StringConfigItem.create!(item_key: "message_input_background", item_value: "#4D4D4F", enabled: true)
child380.move_to_child_of(child181)

child233 = StringConfigItem.create!(item_key: "message_input_text", item_value: "#ffffff", enabled: true)
child233.move_to_child_of(child181)

child234 = StringConfigItem.create!(item_key: "message_input_hint_text", item_value: "#aaaaaa", enabled: true)
child234.move_to_child_of(child181)

child381 = StringConfigItem.create!(item_key: "message_input_highlight", item_value: "#994C8E", enabled: true)
child381.move_to_child_of(child181)

child374 = StringConfigItem.create!(item_key: "content_container_background", item_value: "#4D4D4F", enabled: true)
child374.move_to_child_of(child181)

child375 = StringConfigItem.create!(item_key: "content_container_foreground", item_value: "#FFFFFF", enabled: true)
child375.move_to_child_of(child181)

child376 = StringConfigItem.create!(item_key: "content_container_text", item_value: "#FFFFFF", enabled: true)
child376.move_to_child_of(child181)

child377 = StringConfigItem.create!(item_key: "content_container_secondary_background", item_value: "#292828", enabled: true)
child377.move_to_child_of(child181)

child382 = StringConfigItem.create!(item_key: "content_container_highlighted_text", item_value: "#994C8E", enabled: true)
child382.move_to_child_of(child181)

child204 = RootConfigItem.create!(item_key: "certificates", item_value: "", enabled: true)

child205 = RootConfigItem.create!(item_key: "colors", item_value: "", enabled: true)
child205.move_to_child_of(child204)

child206 = StringConfigItem.create!(item_key: "certificate_list_background", item_value: "#A7A9AC", enabled: true)
child206.move_to_child_of(child205)

child207 = StringConfigItem.create!(item_key: "certificate_list_text", item_value: "#FFFFFF", enabled: true)
child207.move_to_child_of(child205)

child208 = StringConfigItem.create!(item_key: "course_list_background", item_value: "#A7A9AC", enabled: true)
child208.move_to_child_of(child205)

child209 = StringConfigItem.create!(item_key: "course_list_foreground", item_value: "#FFFFFF", enabled: true)
child209.move_to_child_of(child205)

child210 = StringConfigItem.create!(item_key: "certificate_icon_inactive", item_value: "#FFFFFF", enabled: true)
child210.move_to_child_of(child205)

child211 = StringConfigItem.create!(item_key: "certificate_icon_active", item_value: "#994C8E", enabled: true)
child211.move_to_child_of(child205)

child212 = StringConfigItem.create!(item_key: "quiz_correct", item_value: "#417505", enabled: true)
child212.move_to_child_of(child205)

child213 = StringConfigItem.create!(item_key: "quiz_incorrect", item_value: "#d0021b", enabled: true)
child213.move_to_child_of(child205)

child214 = RootConfigItem.create!(item_key: "chat", item_value: "", enabled: true)

child215 = RootConfigItem.create!(item_key: "colors", item_value: "", enabled: true)
child215.move_to_child_of(child214)

child220 = StringConfigItem.create!(item_key: "pinned_container_background", item_value: "#4D4D4F", enabled: true)
child220.move_to_child_of(child215)

child386 = StringConfigItem.create!(item_key: "pinned_container_foreground", item_value: "#AAAAAA", enabled: true)
child386.move_to_child_of(child215)

child237 = StringConfigItem.create!(item_key: "chat_date_box_background", item_value: "#4D4D4F", enabled: true)
child237.move_to_child_of(child215)

child238 = StringConfigItem.create!(item_key: "chat_date_box_text", item_value: "#FFFFFF", enabled: true)
child238.move_to_child_of(child215)

child239 = BooleanConfigItem.create!(item_key: "has_video_upload", item_value: "t", enabled: true)
child239.move_to_child_of(child214)

child240 = BooleanConfigItem.create!(item_key: "has_photo_upload", item_value: "t", enabled: true)
child240.move_to_child_of(child214)

child241 = RootConfigItem.create!(item_key: "feed", item_value: "", enabled: true)

child242 = RootConfigItem.create!(item_key: "colors", item_value: "", enabled: true)
child242.move_to_child_of(child241)

child248 = StringConfigItem.create!(item_key: "poll_text", item_value: "#ffffff", enabled: true)
child248.move_to_child_of(child242)

child249 = StringConfigItem.create!(item_key: "poll_option_text", item_value: "#000000", enabled: true)
child249.move_to_child_of(child242)

child250 = StringConfigItem.create!(item_key: "poll_empty", item_value: "#ffffff", enabled: true)
child250.move_to_child_of(child242)

child251 = StringConfigItem.create!(item_key: "poll_fill", item_value: "#FF7F7F", enabled: true)
child251.move_to_child_of(child242)

child252 = StringConfigItem.create!(item_key: "reaction_counter_text", item_value: "#994C8E", enabled: true)
child252.move_to_child_of(child242)

child253 = StringConfigItem.create!(item_key: "reaction_counter_container", item_value: "#994C8E", enabled: true)
child253.move_to_child_of(child242)

child240 = BooleanConfigItem.create!(item_key: "has_polls_posts", item_value: "t", enabled: true)
child240.move_to_child_of(child241)

child263 = RootConfigItem.create!(item_key: "profile",item_value: "", enabled: true)

child264 = RootConfigItem.create!(item_key: "colors",item_value: "", enabled: true)
child264.move_to_child_of(child263)

child267 = StringConfigItem.create!(item_key: "profile_container_relationship_text",item_value: "#808080",enabled: true)
child267.move_to_child_of(child264)

child275 = RootConfigItem.create!(item_key: "trivia",item_value: "", enabled: true)

child276 = RootConfigItem.create!(item_key: "colors",item_value: "", enabled: true)
child276.move_to_child_of(child275)

child277 = StringConfigItem.create!(item_key: "list_item_background",item_value: "#A7A9AC",enabled: true)
child277.move_to_child_of(child276)
child278 = StringConfigItem.create!(item_key: "list_item_text_title",item_value: "#000000",enabled: true)
child278.move_to_child_of(child276)
child279 = StringConfigItem.create!(item_key: "list_item_text_info",item_value: "#000000",enabled: true)
child279.move_to_child_of(child276)

# child280 = RootConfigItem.create!(item_key: "discover",item_value: "", enabled: true)
#
# child276 = BooleanConfigItem.create!(item_key: "has_search_by_interests",item_value: "t", enabled: true)
# child276.move_to_child_of(child280)

child289 = ArrayConfigItem.create!(item_key: "onboarding_screens",item_value: "", enabled: true)

child290 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child290.move_to_child_of(child289)

child366 = StringConfigItem.create!(item_key: "order",item_value: "1",enabled: true)
child366.move_to_child_of(child290)

child291 = StringConfigItem.create!(item_key: "title",item_value: "Welcome to Can-Ed",enabled: true)
child291.move_to_child_of(child290)

child292 = StringConfigItem.create!(item_key: "short_description",item_value: "The number one cannabis education app that fits right in your pocket and provides quality cannabis education while you're on the go.",enabled: true)
child292.move_to_child_of(child290)

child293 = StringConfigItem.create!(item_key: "long_description",item_value: nil,enabled: true)
child293.move_to_child_of(child290)

child294 = StringConfigItem.create!(item_key: "image",item_value: "https://www.birmingham.ac.uk/Images/News/Forest-900.jpg",enabled: true)
child294.move_to_child_of(child290)

child295 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true,item_url:"https://www.theglobeandmail.com/resizer/VWnRys1y1IzVh0m5UvzYHu-FGkE=/620x0/filters:quality(80)/arc-anglerfish-tgam-prod-tgam.s3.amazonaws.com/public/4ETF3GZR3NA3RDDW23XDRBKKCI")
child295.move_to_child_of(child290)

child296 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#7b42f5",enabled: true)
child296.move_to_child_of(child290)

child297 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child297.move_to_child_of(child290)


child298 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child298.move_to_child_of(child289)

child368 = StringConfigItem.create!(item_key: "order",item_value: "2",enabled: true)
child368.move_to_child_of(child298)

child299 = StringConfigItem.create!(item_key: "title",item_value: "Certifications",enabled: true)
child299.move_to_child_of(child298)

child300 = StringConfigItem.create!(item_key: "short_description",item_value:"The first step to earning your cannabis career certification is to sign-up for a course. Next, complete the modules, pass the quizzes, and voila! Certification earned. It's that easy.",enabled: true)
child300.move_to_child_of(child298)

child301 = StringConfigItem.create!(item_key: "long_description",item_value: nil,enabled: true)
child301.move_to_child_of(child298)

child302 = StringConfigItem.create!(item_key: "image",item_value: "https://utlto/onboarding_2.png",enabled: true)
child302.move_to_child_of(child298)

child303 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true)
child303.move_to_child_of(child298)

child304 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#2b2a2a",enabled: true)
child304.move_to_child_of(child298)

child305 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child305.move_to_child_of(child298)

child306 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child306.move_to_child_of(child289)

child367 = StringConfigItem.create!(item_key: "order",item_value: "3",enabled: true)
child367.move_to_child_of(child306)

child307 = StringConfigItem.create!(item_key: "title",item_value: "Chat",enabled: true)
child307.move_to_child_of(child306)

child308 = StringConfigItem.create!(item_key: "short_description",item_value:  "Connect with fellow students and instructors. Discuss course material, ask questions, or discuss what's on your mind. Just keep it course and cannabis related.",enabled: true)
child308.move_to_child_of(child306)

child309 = StringConfigItem.create!(item_key: "long_description",item_value: nil,enabled: true)
child309.move_to_child_of(child306)

child310 = StringConfigItem.create!(item_key: "image",item_value: "https://utlto/onboarding_3.png",enabled: true)
child310.move_to_child_of(child306)

child311 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true)
child311.move_to_child_of(child306)

child312 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#34fa07",enabled: true)
child312.move_to_child_of(child306)

child313 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child313.move_to_child_of(child306)

child314 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child314.move_to_child_of(child289)

child365 = StringConfigItem.create!(item_key: "order",item_value: "4",enabled: true)
child365.move_to_child_of(child314)

child315 = StringConfigItem.create!(item_key: "title",item_value: "Discover",enabled: true)
child315.move_to_child_of(child314)

child316 = StringConfigItem.create!(item_key: "short_description",item_value:"Search and find. Select your interests and discover people on the app who like the same things as you do. You may be surprised by what you have in common.",enabled: true)
child316.move_to_child_of(child314)

child317 = StringConfigItem.create!(item_key: "long_description",item_value: nil,enabled: true)
child317.move_to_child_of(child314)

child318 = StringConfigItem.create!(item_key: "image",item_value: "https://utlto/onboarding_4.png",enabled: true)
child318.move_to_child_of(child314)

child319 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true)
child319.move_to_child_of(child314)

child320 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#2b2a2a",enabled: true)
child320.move_to_child_of(child314)

child321 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child321.move_to_child_of(child314)

child322 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child322.move_to_child_of(child289)

child364 = StringConfigItem.create!(item_key: "order",item_value: "5",enabled: true)
child364.move_to_child_of(child322)

child323 = StringConfigItem.create!(item_key: "title",item_value: "Feed",enabled: true)
child323.move_to_child_of(child322)

child324 = StringConfigItem.create!(item_key: "short_description",item_value:"Stay in the know. Find out what's happening in the cannabis industry, learn about job opportunities, and get in on the conversation with others in the Can-Ed community.",enabled: true)
child324.move_to_child_of(child322)

child325 = StringConfigItem.create!(item_key: "long_description",item_value: nil,enabled: true)
child325.move_to_child_of(child322)

child326 = StringConfigItem.create!(item_key: "image",item_value: "https://utlto/onboarding_5.png",enabled: true)
child326.move_to_child_of(child322)

child327 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true)
child327.move_to_child_of(child322)

child328 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#2b2a2a",enabled: true)
child328.move_to_child_of(child322)

child329 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child329.move_to_child_of(child322)




child330 = RootConfigItem.create!(item_key: "",item_value: "",enabled: true)
child330.move_to_child_of(child289)

child363 = StringConfigItem.create!(item_key: "order",item_value: "6",enabled: true)
child363.move_to_child_of(child330)

child331 = StringConfigItem.create!(item_key: "title",item_value: "Profile",enabled: true)
child331.move_to_child_of(child330)

child332 = StringConfigItem.create!(item_key: "short_description",item_value:"Getting to know you. Create a custom profile by adding a picture, a bio, and selecting your interests.",enabled: true)
child332.move_to_child_of(child330)

child333 = StringConfigItem.create!(item_key: "long_description",item_value: "Feel good factor not CO2 boosts global forest expansionFeel good factor not CO2 boosts global forest expansionFeel good factor not CO2 boosts global forest expansionFeel good factor not CO2 boosts global forest expansionFeel good factor not CO2 boosts global forest expansionFeel good factor not CO2 boosts global forest expansion",enabled: true)
child333.move_to_child_of(child330)

child334 = StringConfigItem.create!(item_key: "image",item_value: "https://utlto/onboarding_6.png",enabled: true)
child334.move_to_child_of(child330)

child335 = StringConfigItem.create!(item_key: "bg_start_color",item_value: "#000000",enabled: true)
child335.move_to_child_of(child330)


child336 = StringConfigItem.create!(item_key: "bg_end_color",item_value: "#2b2a2a",enabled: true)
child336.move_to_child_of(child330)

child337 = StringConfigItem.create!(item_key: "fg_color",item_value: "#ffffff",enabled: true)
child337.move_to_child_of(child330)

child338 = RootConfigItem.create!(item_key: "", item_value: "", enabled: true)
child362.move_to_child_of(child289)

child362 = StringConfigItem.create!(item_key: "order", item_value: "7", enabled: true)
child362.move_to_child_of(child338)

child339 = StringConfigItem.create!(item_key: "title", item_value: "Support", enabled: true)
child339.move_to_child_of(child338)

child340 = StringConfigItem.create!(item_key: "short_description", item_value: "Chat with our support team through the private chat message that will be saved on your chat tab. We are available Monday-Friday 8am - 3pm PST but you can send us a message any time.", enabled: true)
child340.move_to_child_of(child338)

child341 = StringConfigItem.create!(item_key: "long_description", item_value: nil, enabled: true)
child341.move_to_child_of(child338)

child342 = StringConfigItem.create!(item_key: "image", item_value: "https://www.theglobeandmail.com/resizer/VWnRys1y1IzVh0m5UvzYHu-FGkE=/620x0/filters:quality(80)/arc-anglerfish-tgam-prod-tgam.s3.amazonaws.com/public/4ETF3GZR3NA3RDDW23XDRBKKCI", enabled: true)
child342.move_to_child_of(child338)

child343 = StringConfigItem.create!(item_key: "bg_start_color", item_value: "#000000", enabled: true)
child343.move_to_child_of(child338)

child344 = StringConfigItem.create!(item_key: "bg_end_color", item_value: "#f54269", enabled: true)
child344.move_to_child_of(child338)

child345 = StringConfigItem.create!(item_key: "fg_color", item_value: "#ffffff", enabled: true)
child345.move_to_child_of(child338)
