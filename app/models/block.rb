class Block < ApplicationRecord
  belongs_to :blocker, class_name: "Person"
  belongs_to :blocked, class_name: "Person"
end
