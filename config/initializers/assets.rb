# Be sure to restart your server when you modify this file.
# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.3"
# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join("node_modules")
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w(rails_admin/custom/theming.css rails_admin/custom/ui.js)
Rails.application.config.assets.precompile += %w(admin/custom.scss admin/google_places.scss admin/events.js admin/message_reports.js admin/post_reports.js admin/translated_fields.js)
Rails.application.config.assets.precompile += %w( bootstrap-notify.js )
