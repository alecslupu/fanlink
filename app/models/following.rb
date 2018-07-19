class Following < ApplicationRecord
  belongs_to :follower, class_name: "Person", touch: true
  belongs_to :followed, class_name: "Person", touch: true
end
