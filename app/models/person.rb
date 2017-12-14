class Person < ApplicationRecord
  include Person::Facebook

  authenticates_with_sorcery!

  acts_as_tenant(:product)

  #belongs_to :product

  before_validation :normalize_email
  before_validation :canonicalize_username, if: :username_changed?

  validates_uniqueness_to_tenant [:email, :username]

  validates :facebookid, uniqueness: { scope: :product_id, allow_nil: true }

  validates :email, email: true, presence: true, if: Proc.new { |p| p.facebookid.blank? }

  validates :username, presence: { message: "is required." }
  validates :username, length: { in: 3..26, message: "must be between 3 and 26 characters" }

  validates :password, length: { minimum: 6 }, if: -> { facebookid.blank? && (new_record? || changes[:crypted_password]) }

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

    #
    # This `valid?` stuff is a bit smelly but not too bad.
    #
    # add_error = lambda do |person, msg|
    #   person.errors.add(:base, msg)
    #   def person.valid?
    #     false
    #   end
    # end
    # if(person.suspended?)
    #   support = opts[:property].try(:support_email) || 'support@flink.to'
    #   add_error[person, _('Your account is currently suspended. Please contact support at %{support_email}') % { :support_email => support }]
    # end
    #person
  end

  def self.can_login_as_admin?(email)
    person = can_login?(email)
    (person && person.username == "admin") ? person : nil
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

  def picture_url
    facebook_picture_url #TBD attachment support TBD
  end

  #
  # Check if a username is in use or not. If you give us a `person_id`,
  # we'll ignore a match with that person.
  #
  # @param [String] name
  #   The username to check.
  # @param [ObjectID, Person, String] person
  #   The (optional) person.
  # @return [Boolean]
  #   True if the name is used, false otherwise.
  #
  def self.username_used?(name, person = nil)
    query = where(username_canonical: canonicalize(name))
    query = query.where.not(id: person.to_id) if person
    query.count > 0
  end


  private

    def canonicalize(name)
      self.class.canonicalize(name)
    end

    def canonicalize_username
      self.username_canonical = canonicalize(self.username)
      true
    end

    def normalize_email
      self.email = self.email.strip.downcase if self.email_changed? && self.email.present?
      true
    end
end
