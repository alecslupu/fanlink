# frozen_string_literal: true

# == Schema Information
#
# Table name: post_reactions
#
#  id        :bigint(8)        not null, primary key
#  post_id   :integer          not null
#  person_id :integer          not null
#  reaction  :text             not null
#

class PostReaction < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :person

  has_paper_trail

  validate :check_emoji
  validates :person, uniqueness: { scope: :post, message: _("You have already reacted to this post.") }
  validates :reaction, presence: { message: _("Reaction is required.") }


  def self.group_reactions(post)
    Rails.cache.fetch([post, "reactions"]) {
      PostReaction.where(post_id: post.id).group(:reaction).size
    }
  end
  private

    def check_emoji
      bottom = 0x0
      top = 0x10FFFF
      hex_val = reaction.to_i(16)
      if hex_val < bottom || hex_val > top
        errors.add(:reaction, :reaction_not_valid, message: _("Reaction is not a valid value."))
      end
    end
end
