class PostTag < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :tag
end
