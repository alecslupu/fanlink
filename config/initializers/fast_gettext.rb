FastGettext.add_text_domain "FanLink", path: "locale", type: :po
FastGettext.default_available_locales = TranslationThings::LANGS.keys - ["un"]
FastGettext.default_text_domain = "FanLink"
