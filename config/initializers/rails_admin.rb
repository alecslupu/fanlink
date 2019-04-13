RailsAdmin.config do |config|

  config.main_app_name = ["Cool app", "BackOffice"]
  # or something more dynamic
  config.main_app_name = Proc.new { |controller| [ "Cool app", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }


  config.included_models = %w(
    Certificate
    Trivia::Game

    ActionType
    Badge
    Event
    Level
    Merchandise
    Message
    MessageReport
    Person
    PortalAccess
    PortalNotification
    Post
    PostReport
    Product
    Room
  )

  config.model "Trivia::Game" do
    navigation_label "Trivia"
  end

  %w(
    Trivia::QuestionPackage
    Trivia::AvailableAnswer
    Trivia::GameLeaderboard
    Trivia::QuestionPackageLeaderboard
    Trivia::Participant
    Trivia::Prize
    Trivia::Question
    Trivia::QuestionLeaderboard
    Trivia::Answer
  ).each do |model|
    config.included_models << model
    config.model model do
      parent Trivia::Game
    end
  end

  config.model "Certificate" do
    navigation_label "Courseware"
  end

  %w(Certcourse CertcoursePage CertificateCertcourse Answer ImagePage PersonCertcourse PersonCertificate PersonQuiz QuizPage VideoPage).each do |model|
    config.included_models << model
    config.model model do
      parent Certificate
    end
  end

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
  #   # config.current_user_method(&:current_user)

  config.authenticate_with do
    # Use sorcery's before filter to auth users
    require_login
  end
  #   ## == Cancan ==
  #   # config.authorize_with :cancan
  #
  #   ## == Pundit ==
  #   # config.authorize_with :pundit
  #
  #   ## == PaperTrail ==
  #   # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  #
  #   ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  #
  #   ## == Gravatar integration ==
  #   ## To disable Gravatar integration in Navigation Bar set to false
  #   # config.show_gravatar = true
  #
  #   config.actions do
  #     dashboard                     # mandatory
  #     index                         # mandatory
  #     new
  #     export
  #     bulk_delete
  #     show
  #     edit
  #     delete
  #     show_in_app
  #
  #     ## With an audit adapter, you can add:
  #     # history_index
  #     # history_show
  #   end
end
