class Room < ApplicationRecord
  enum status: %i[ inactive active deleted ]

  acts_as_tenant(:product)

  belongs_to :created_by, class_name: "Person"

  before_validation :canonicalize_name, if: :name_changed?

  has_many :room_memberships, dependent: :destroy
  has_many :members, through: :room_memberships, source: :person

  has_many :messages, dependent: :restrict_with_error

  validate :name_uniqueness
  validates :name, presence: { message: "Room name is required." }, if: Proc.new { |r| r.public? }
  validates :name, length: { in: 3..36, message: "Room name must be between 3 and 36 characters", allow_blank: true }

  scope :privates, -> (member) { joins(:room_memberships).where("room_memberships.person_id = ? and rooms.public = ?", member.id, false) }
  scope :publics, -> { where(public: true) }

  #
  # Return the canonical form of a name.
  #
  # @param [String] name
  #   The incoming username.
  # @return [String]
  #   The canonical version of `name`.
  #
  def self.canonicalize(name)
    StringUtil.search_ify(name)
  end

  def is_member?(person)
    members.include?(person)
  end

  def private?
    !public
  end

private

  def canonicalize(name)
    self.class.canonicalize(name)
  end

  def canonicalize_name
    self.name_canonical = canonicalize(self.name)
    true
  end

  def name_uniqueness
    if public
      if Room.where.not(id: self.id).where(public: true).where(name_canonical: self.name_canonical).exists?
        errors.add(:name, "A public room already exists with that name")
      end
    else
      if Room.where.not(id: self.id).where(public: false).where(created_by_id: self.created_by_id, name: name).exists?
        errors.add(:name, "You have already created a room with the name #{name}.")
      end
    end
  end
end
