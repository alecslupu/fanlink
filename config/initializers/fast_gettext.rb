# frozen_string_literal: true

FastGettext.add_text_domain "FanLink", path: "locale", type: :po
FastGettext.default_locale = "en"
FastGettext.default_available_locales = ["en", "es", "ro"]
FastGettext.default_text_domain = "FanLink"
