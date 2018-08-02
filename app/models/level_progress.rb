class LevelProgress < ApplicationRecord
  belongs_to :person, touch: true
end
