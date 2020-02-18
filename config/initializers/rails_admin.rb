Dir[Rails.root.join("app/lib/rails_admin/extensions/pundit/*.rb")].each { |f| require f }
Dir[Rails.root.join("app/lib/rails_admin/config/actions/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("app/lib/rails_admin/config/actions/*.rb")].each { |f| require f }
Dir[Rails.root.join("app/lib/rails_admin/config/fields/types/*.rb")].each { |f| require f }
Dir[Rails.root.join("config/initializers/rails_admin/*.rb")].each { |f| require f }

RailsAdmin.config do |config|
  config.main_app_name = ["Fan link", "BackOffice"]
  # or something more dynamic
  config.main_app_name = proc { |controller| [ "Cool app", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }

  config.parent_controller = "RailsAdminController"

  #
  # %w(PostComment PostReaction PostReport PostCommentReport PostTag).each do |model|
  #   config.model model do
  #     parent Post
  #   end
  # end
  #
  #   ### Popular gems integration
  #
  #   ## == Devise ==
  #   # config.authenticate_with do
  #   #   warden.authenticate! scope: :user
  #   # end

  config.authenticate_with do
    # Use sorcery's before filter to auth users
    require_login
  end
  config.current_user_method(&:current_user)
  #   ## == Cancan ==
  #   config.authorize_with :cancan
  #
  #   ## == Pundit ==
  config.authorize_with :pundit
  #   ## == PaperTrail ==
  config.audit_with :paper_trail, "Person", "PaperTrail::Version" # PaperTrail >= 3.0.0
  #
  #   ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  #
  #   ## == Gravatar integration ==
  #   ## To disable Gravatar integration in Navigation Bar set to false
  #   # config.show_gravatar = true

  # config.included_models.push("Courseware::Client::ClientToPerson")
  # config.included_models.push("Courseware::Client::Assigned")
  # config.included_models.push("Courseware::Client::Designated")

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    history_index
    history_show

    forget_action do
      only ["PersonCertcourse"]
    end
    reset_progress_action do
      only ["PersonCertcourse"]
    end

    hide_message_action do
      only ["MessageReport"]
    end
    reanalyze_message_action do
      only ["MessageReport"]
    end
    ignore_message_action do
      only ["MessageReport"]
    end
    hide_post_report_action do
      only ["PostReport"]
    end
    reanalyze_post_report_action do
      only ["PostReport"]
    end

    ignore_post_report_action do
      only ["PostReport"]
    end

    hide_action do
      only ["Message"]
    end

    unhide_action do
      only ["Message"]
    end

    referral_purchase_report_action do
      only ["Referral::ReferredPerson"]
    end

    referral_report_action do
      only ["Referral::ReferredPerson"]
    end

    generate_game_action do
      only ["Trivia::Game"]
    end

    select_product_dashboard
    select_product_action
    nested_set do
      visible do
        %w(ConfigItem).include? bindings[:abstract_model].model_name
      end
    end
  end
end
