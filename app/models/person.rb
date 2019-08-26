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
  include Person::Blocks
  include Person::Badges
  include Person::Facebook
  include Person::Filters
  include Person::Followings
  include Person::Levels
  include Person::Mailing
  include Person::Profile
  include Person::Relationships

  include Person::Trivia

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

  before_validation :normalize_email
  before_validation :canonicalize_username, if: :username_changed?

  after_commit :flush_cache

  scope :username_filter, -> (query, current_user) { where("people.username_canonical ilike ? AND people.username_canonical != ?", "%#{canonicalize(query.to_s)}%", "#{canonicalize(current_user.username.to_s)}") }
  scope :email_filter, -> (query, current_user) { where("people.email ilike ? AND people.email != ?", "%#{query}%", "#{current_user.email}") }
  scope :product_account_filter, -> (query, current_user) { where("people.product_account = ?", "#{query}") }

  validates :facebookid, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that Facebook account.") }
  validates :email, uniqueness: { scope: :product_id, allow_nil: true, message: _("A user has already signed up with that email address.") }
  validates :username, uniqueness: { scope: :product_id, message: _("A user has already signed up with that username.") }

  validates :email, presence: { message: _("Email is required.") }, if: Proc.new { |person| person.facebookid.blank? }
  validates :email, email: { message: _("Email is invalid."), allow_nil: true }

  validates :username, presence: { message: _("Username is required.") }
  validates :username, length: { in: 3..26, message: _("Username must be between 3 and 26 characters") }

  validates :username, emoji: true
  validates :password, presence: { message: _("Password is required.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }
  validates :password, length: { minimum: 6, allow_blank: true, message: _("Password must be at least 6 characters in length.") }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }

  validates :name, emoji: true
  # validates :birthdate, presence: { message: "is required." }

  validate :check_role
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

  def jwt_token
    ::TokenProvider.issue_token(user_id: self.id)
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
        errors.add(:username, :username_in_use, message: _("A user has already signed up with that username."))
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

    def normalize_email
      self.email = self.email.strip.downcase if self.email_changed? && self.email.present?
      true
    end
end
