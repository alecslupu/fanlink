class Product < ApplicationRecord
  #has_paper_trail

  validates :name, length: { in: 3..60, message: "must be between 3 and 60 characters" }

  validates :subdomain, format: { with: /\A[a-zA-Z0-9][a-zA-Z0-9.-]+[a-zA-Z0-9]\z/ },
            length: { in: 3..63, message: "must be between 3 and 63 characters" }
end
