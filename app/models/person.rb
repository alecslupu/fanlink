# == Schema Information
#
# Table name: people
#
#  id                              :bigint(8)        not null, primary key
#  username                        :text             not null
#  username_canonical              :text             not null
#  email                           :text
#  name                            :text
#  product_id                      :integer          not null
#  crypted_password                :text
#  salt                            :text
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  facebookid                      :text
#  facebook_picture_url            :text
#  picture_file_name               :string
#  picture_content_type            :string
#  picture_file_size               :integer
#  picture_updated_at              :datetime
#  do_not_message_me               :boolean          default(FALSE), not null
#  pin_messages_from               :boolean          default(FALSE), not null
#  auto_follow                     :boolean          default(FALSE), not null
#  role                            :integer          default("normal"), not null
#  reset_password_token            :text
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  product_account                 :boolean          default(FALSE), not null
#  chat_banned                     :boolean          default(FALSE), not null
#  designation                     :jsonb            not null
#  recommended                     :boolean          default(FALSE), not null
#  gender                          :integer          default("unspecified"), not null
#  birthdate                       :date
#  city                            :text
#  country_code                    :text
#  biography                       :text
#  tester                          :boolean          default(FALSE)
#  terminated                      :boolean          default(FALSE)
#  terminated_reason               :text
#  deleted                         :boolean          default(FALSE)
#

class Person < ApplicationRecord
  include AttachmentSupport
  # include Person::Blocks
  # include Person::Facebook
  # include Person::Filters
  # include Person::Followings
  # include Person::Levels
  # include Person::Mailing
  # include Person::Profile

  include TranslationThings
  authenticates_with_sorcery!

  attr_accessor :app

  has_manual_translated :designation

  has_paper_trail

  enum role: %i[ normal staff admin super_admin ]

  normalize_attributes :name, :birthdate, :city, :country_code, :biography, :terminated_reason

  acts_as_tenant(:product)

  belongs_to :product

  has_image_called :picture
  has_many :message_reports, dependent: :destroy
  has_many :notification_device_ids, dependent: :destroy
  has_many :post_reactions, dependent: :destroy
  has_many :room_memberships, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :quest_completions, dependent: :destroy
  has_many :step_completed, dependent: :destroy
  has_many :quest_completed, dependent: :destroy
  has_many :person_rewards, dependent: :destroy
  has_many :person_interests, dependent: :destroy
  has_many :level_progresses, dependent: :destroy
  has_many :reward_progresses, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :pin_messages, dependent: :destroy

  has_many :private_rooms, through: :room_memberships, source: :room
  has_many :pinned_to, through: :pin_messages, source: :room
  has_one :portal_access, dependent: :destroy

  has_many :rewards, through: :person_rewards
  has_many :interests, through: :person_interests
  has_many :event_checkins, dependent: :destroy

  has_many :person_poll_options
  has_many :poll_options, through: :person_poll_options, dependent: :destroy

  has_many :person_certificates
  has_many :certificates, through: :person_certificates, dependent: :destroy

  has_many :course_page_progresses, dependent: :destroy

  has_many :person_certcourses
  has_many :certcourses, through: :person_certcourses, dependent: :destroy

  has_many :badge_actions, dependent: :destroy
  has_many :badge_awards

  has_many :badges, through: :badge_awards


  has_many :trivia_game_leaderboards, class_name: "Trivia::GameLeaderboard"
  has_many :trivia_package_leaderboards, class_name: "Trivia::RoundLeaderboard"
  has_many :trivia_question_leaderboards, class_name: "Trivia::QuestionLeaderboard"
  has_many :trivia_answers, class_name: "Trivia::Answer"
  has_many :trivia_subscribers, class_name: "Trivia::Subscriber"

  has_many :relationships, ->(person) { unscope(:where).where("requested_by_id = :id OR requested_to_id = :id", id: person.id) }


  has_many :blocks_by,  class_name: "Block", foreign_key: "blocker_id", dependent: :destroy
  has_many :blocks_on, class_name: "Block", foreign_key: "blocked_id", dependent: :destroy

  has_many :blocked_people, through: :blocks_by, source: :blocked
  has_many :blocked_by_people, through: :blocks_on, source: :blocker

  has_many :active_followings, class_name:  "Following", foreign_key: "follower_id", dependent: :destroy

  has_many :passive_followings, class_name:  "Following", foreign_key: "followed_id", dependent: :destroy

  has_many :following, through: :active_followings, source: :followed
  has_many :followers, through: :passive_followings, source: :follower

  has_many :notifications, dependent: :destroy

  before_validation :normalize_email
  before_validation :canonicalize_username, if: :username_changed?

  after_commit :flush_cache

  # scope :username_filter, -> (query) { where("people.username_canonical ilike ?", "%#{query}%") }
  scope :username_filter, -> (query, current_user) { where("people.username_canonical ilike ? AND people.username_canonical != ?", "%#{canonicalize(query.to_s)}%", "#{canonicalize(current_user.username.to_s)}") }
  # scope :email_filter,    -> (query) { where("people.email ilike ?", "%#{query}%") }
  scope :email_filter, -> (query, current_user) { where("people.email ilike ? AND people.email != ?", "%#{query}%", "#{current_user.email}") }
  scope :product_account_filter, -> (query, current_user) { where("people.product_account = ?", "#{query}") }

  validates :facebookid, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that Facebook account.") }
  validates :email, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that email address.") }
  validates :username, uniqueness: { scope: :product_id, message: _("The username has already been taken.") }

  validates :email, presence: { message: _("Email is required.") }, if: Proc.new { |person| person.facebookid.blank? }
  validates :email, email: { message: _("Email is invalid."), allow_nil: true }

  validates :username, presence: { message: _("Username is required.") }

  validates :username, emoji: true, on: :create
  validates :password, presence: { message: _("Password is required.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }
  validates :password, length: { minimum: 6, allow_blank: true, message: _("Password must be at least 6 characters in length.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }

  # validates :name, emoji: true, on: :create
  # validates :birthdate, presence: { message: "is required." }

  validate :check_role

  # Check if username has any special characters and if length is between 5 and 25
  validate :valid_username
  enum gender: %i[ unspecified male female ]

  validate :valid_country_code
  validates :country_code, length: { is: 2 }, allow_blank: true

  def country_code=(c)
    write_attribute :country_code, (c.nil?) ? nil : c.upcase
  end

  # validate :validate_age
  #
  # Return the canonical form of a username.
  #
  # @param [String] username
  #   The incoming username.
  # @return [String]
  #   The canonical version of `username`.
  #
  def self.canonicalize(username)
    StringUtil.search_ify(username)
  end


  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def friends
    relationships.where(status: :friended)
  end

  def friend_request_count
    relationships.where(requested_to: self).where(status: :requested).count
  end

  def jwt_token
    ::TokenProvider.issue_token(user_id: self.id)
  end

  def send_onboarding_email
    Delayed::Job.enqueue(OnboardingEmailJob.new(self.id))
  end


  def send_password_reset_email
    Delayed::Job.enqueue(PasswordResetEmailJob.new(self.id))
  end

  def send_certificate_email(certificate_id, email)
    Delayed::Job.enqueue(SendCertificateEmailJob.new(self.id, certificate_id, email))
  end

  def send_course_attachment_email(certcourse_page)
    Delayed::Job.enqueue(SendDownloadFileEmailJob.new(self.id, certcourse_page.id))
  end

  def self.create_from_facebook(token, username)
    person = nil
    begin
      graph = Koala::Facebook::API.new(token)
      results = graph.get_object("me", fields: [:id, :email, :picture])
    rescue Koala::Facebook::APIError, Koala::Facebook::AuthenticationError => error
      Rails.logger.warn("Error contacting facebook for #{username} with token #{token}")
      Rails.logger.warn("Message: #{error.fb_error_message}")
      return nil
    end
    Rails.logger.error(results.inspect)
    if results && results["id"].present?
      person = Person.create(facebookid: results["id"],
                             username: username,
                             email: results["email"],
                             facebook_picture_url: results.dig("picture", "data", "url"))
    end
    person
  end

  def self.for_facebook_auth_token(token)
    person = nil
    begin
      graph = Koala::Facebook::API.new(token)
      results = graph.get_object("me", fields: [:id])
    rescue Koala::Facebook::APIError => error
      Rails.logger.warn("Error contacting facebook for login with token #{token}")
      Rails.logger.warn("Message: #{error.fb_error_message}")
      return nil
    end
    if results && results["id"].present?
      person = Person.find_by(facebookid: results["id"])
    end
    person
  end

  def cache_key_follow_person(ver, app_source, user, person)
    [ver, "person", app_source, user.id,  person.id, person.updated_at.to_i]
  end

  def do_auto_follows
    Person.where(auto_follow: true).each do |person|
      follow(person)
    end
  end

  def follow(followed)
    active_followings.find_or_create_by(followed_id: followed.id)
  end

  def following?(someone)
    following.include?(someone)
  end

  def following_for_person(person)
    active_followings.find_by(followed_id: person.id)
  end

  def unfollow(someone)
    following.delete(someone)
  end

  def level_earned_from_progresses(progresses)
    points = progresses.first.try(:total) || 0
    determine_level(points)
  end

  def level
    level_earned.as_json(only: %i[ id name internal_name points ], methods: %i[ picture_url ])
  end

  def level_earned
    points = level_progresses.first.try(:total) || 0
    determine_level(points)
  end

  def determine_level(points)
    Level.where(product_id: product.id).where("points <= ?", points).order(points: :desc).first
  end

  def block_with?(person)
    blocks_with.include?(person)
  end

  def blocks_with
    blocked_people + blocked_by_people
  end

  def badge_points
    badges.sum(:point_value)
  end

  def block(blocked)
    blocks_by.create(blocked_id: blocked.id)
  end

  def blocked?(person)
    blocked_people.include?(person)
  end

  def unblock(blocked)
    blocked_people.destroy(blocked)
  end
  #
  # Lookup a person via their username.
  #
  # @param [String] username
  #   The username to look up.
  # @return [Person]
  #   The person object or `nil`.
  #
  def self.for_username(username)
    self.find_by(username_canonical: canonicalize(username.to_s))
  end

  #
  # Check if someone can login (does not authenticate..sorcery does that).
  #
  # @param [String] email
  #   The email/username.
  # @return [Person]
  #
  def self.can_login?(email)
    email = email.to_s
    query = email.include?("@") ? { email: email.strip.downcase } : { username_canonical: canonicalize(email) }
    Person.find_by(query)
  end

  def device_tokens
    notification_device_ids.map(&:device_identifier)
  end

  #
  # Return a scoped query for people whose names match a string.
  #
  # @param [String] query
  #   What you're looking for in a name.
  # @return [ActiveRecord_Relation]
  #   The scoped query.
  #
  def self.named_like(term)
    where("people.username_canonical ilike ?", "%#{StringUtil.search_ify(term)}%").first
  end

  def self.current_user
    Thread.current[:user]
  end

  def self.current_user=(user)
    Thread.current[:user] = user
  end

  def reset_password_to(password)
    self.password = password
    self.reset_password_token = nil
    self.save
  end

  def set_password_token!
    self.reset_password_token = UUIDTools::UUID.random_create.to_s
    save!
  end

  def permissions
    1
  end

  def roles_for_select
    (product.can_have_supers?) ? Person.roles : Person.roles.except(:super_admin)
  end

  def some_admin?
    !normal?
  end

  def to_s
    name || username
  end

  def title
    username
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  private
    def canonicalize(name)
      self.class.canonicalize(name)
    end

    def canonicalize_username
      if Person.find_by(username_canonical: canonicalize(self.username), product_id: product.id)
        errors.add(:username, :username_in_use, message: _("has already been taken."))
        false
      else
        self.username_canonical = canonicalize(self.username)
        true
      end
    end

    def check_role
      if super_admin? && !product.can_have_supers
        errors.add(:role, :role_unallowed, message: _("This product cannot have super admins."))
      end
    end

    def validate_age
      if self.birthdate.present? && ((Date.today.to_s(:number).to_i - self.birthdate.to_date.to_s(:number).to_i) / 10000) < product.age_requirement
        errors.add(:age_requirement, :age_not_met, message: _("Age requirement is not met. You must be %{age_requirement} years or older to use this app.") % { age_requirement: product.age_requirement })
      end
    end

  def valid_country_code
    if country_code.present? && ISO3166::Country.find_country_by_alpha2(country_code).nil?
      errors.add(:country_code, message: _("Country code '%{country_code}' is invalid"))
    end
  end

    def normalize_email
      self.email = self.email.strip.downcase if self.email_changed? && self.email.present?
      true
    end

    def valid_username
      if !(/^\w*$/.match(username)) || username.length < 5 || username.length > 25
        errors.add(:username_error, "Username must be 5 to 25 characters with no special characters or spaces")
      end
    end
end
