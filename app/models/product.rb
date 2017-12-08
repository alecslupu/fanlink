class Product < ApplicationRecord
  #has_paper_trail

  validates :name, length: { in: 3..60, message: "must be between 3 and 60 characters" }, uniqueness: true

  validates :internal_name, format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers and underscores" },
            length: { in: 3..30, message: "must be between 3 and 63 characters" },
            uniqueness: true

  has_many :people, dependent: :restrict_with_error
end
