class PostReaction < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :person, touch: true

  has_paper_trail

  validate :check_emoji
  validates :person, uniqueness: { scope: :post, message: _("You have already reacted to this post.") }
  validates :reaction, presence: { message: _("Reaction is required.") }

  private

    def check_emoji
      bottom = 0x0
      top = 0x10FFFF
      hex_val = reaction.to_i(16)
      if hex_val < bottom || hex_val > top
        errors.add(:reaction, _("Reaction is not a valid value."))
      end
    end
end
