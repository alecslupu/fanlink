class Person < ApplicationRecord
  authenticates_with_sorcery!

  include AttachmentSupport

  enum role: %i[ normal staff admin super_admin ]

  # no apparent reason why I have to explicity include this, but no includy if not
  include Sorcery::Model::Submodules::ResetPassword

  include Person::Blocks
  include Person::Badges
  include Person::Facebook
  include Person::Followings
  include Person::Levels
  include Person::Relationships

  acts_as_tenant(:product)

  belongs_to :product

  has_image_called :picture

  has_many :notification_device_ids, dependent: :destroy
  has_many :room_memberships, dependent: :destroy

  has_many :private_rooms, through: :room_memberships

  before_validation :normalize_email
  before_validation :canonicalize_username, if: :username_changed?

  validates :facebookid, uniqueness: { scope: :product_id, allow_nil: true, message: "A user has already signed up with that Facebook account." }
  validates :email, uniqueness: { scope: :product_id, allow_nil: true, message: "A user has already signed up with that email address." }
  validates :username, uniqueness: { scope: :product_id, message: "A user has already signed up with that username." }

  validates :email, presence: { message: "Email is required." }, if: Proc.new { |p| p.facebookid.blank? }
  validates :email, email: { message: "Email is invalid.", allow_nil: true }

  validates :username, presence: { message: "Username is required." }
  validates :username, length: { in: 3..26, message: "Username must be between 3 and 26 characters" }

  validates :password, presence: { message: "Password is required." }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }
  validates :password, length: { minimum: 6, allow_blank: true }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }

  validate :check_role

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
    email  = email.to_s
    query  = email.include?("@") ? { email: email.strip.downcase } : { username_canonical: canonicalize(email) }
    Person.find_by(query)
  end

  def device_tokens
    notification_device_ids.map { |ndi| ndi.device_identifier }
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

  def reset_password_to(password)
    self.password = password
    self.reset_password_token = nil
    self.save
  end

  def set_password_token!
    self.reset_password_token = UUIDTools::UUID.random_create.to_s
    save!
  end

  def roles_for_select
    (product.can_have_supers?) ? Person.roles : Person.roles.except(:super_admin)
  end

  def some_admin?
    !normal?
  end

  private

    def canonicalize(name)
      self.class.canonicalize(name)
    end

    def canonicalize_username
      self.username_canonical = canonicalize(self.username)
      true
    end

    def check_role
      if super_admin? && !product.can_have_supers
        errors.add(:role, "This product cannot have super admins.")
      end
    end

    def normalize_email
      self.email = self.email.strip.downcase if self.email_changed? && self.email.present?
      true
    end
end
