# frozen_string_literal: true
FastGettext.add_text_domain "FanLink", path: "locale", type: :po
FastGettext.default_available_locales = %i[ en es pt ro it de fr ko ar ]
FastGettext.default_text_domain = "FanLink"
