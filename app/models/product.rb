class Product < ApplicationRecord
  # acts_as_api
  include AttachmentSupport
  # include Product::Views
  has_paper_trail

  has_image_called :logo

  validates :name, length: { in: 3..60, message: _("Name must be between 3 and 60 characters.") }, uniqueness: { message: _("Product %{product_name} already exists.") % { product_name: name }}

  validates :internal_name, format: { with: /\A[a-zA-Z0-9_]+\z/, allow_blank: true, message: _("Internal name can only contain letters, numbers and underscores.") },
            presence: { message: _("Internal name is required.") },
            length: { in: 3..30, message: _("Internal name must be between 3 and 63 characters."), allow_blank: true },
            uniqueness: { message: _("Internal name already exists.") }

  has_many :people, dependent: :restrict_with_error
  has_many :quests, dependent: :restrict_with_error
  has_many :product_beacons, dependent: :restrict_with_error
  has_many :events, dependent: :restrict_with_error
  has_many :levels, dependent: :restrict_with_error
  has_many :polls, dependent: :restrict_with_error

  scope :enabled, -> { where(enabled: true) }

  def people_count
    people.count
  end

  def to_s
    internal_name
  end
end
