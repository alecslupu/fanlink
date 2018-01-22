class Product < ApplicationRecord
  #has_paper_trail

  has_many :action_types, dependent: :destroy

  validates :name, length: { in: 3..60, message: "Name must be between 3 and 60 characters" }, uniqueness: true

  validates :internal_name, format: { with: /\A[a-zA-Z0-9_]+\z/, allow_blank: true, message: "Internal name can only contain letters, numbers and underscores" },
            presence: { message: "Internal name is required." },
            length: { in: 3..30, message: "Internal name must be between 3 and 63 characters", allow_blank: true },
            uniqueness: true

  has_many :people, dependent: :restrict_with_error

  def to_s
    name
  end
end
