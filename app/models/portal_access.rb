# == Schema Information
#
# Table name: portal_accesses
#
#  id          :bigint(8)        not null, primary key
#  person_id   :integer          not null
#  post        :integer          default(0), not null
#  chat        :integer          default(0), not null
#  event       :integer          default(0), not null
#  merchandise :integer          default(0), not null
#  user        :integer          default(0), not null
#  badge       :integer          default(0), not null
#  reward      :integer          default(0), not null
#  quest       :integer          default(0), not null
#  beacon      :integer          default(0), not null
#  reporting   :integer          default(0), not null
#  interest    :integer          default(0), not null
#

class PortalAccess < ApplicationRecord
  include FlagShihTzu

  belongs_to :person

  has_flags 1 => :post_read,
            2 => :post_update,
            3 => :post_delete,
            :column => "post"

  has_flags 1 => :chat_read,
            2 => :chat_update,
            3 => :chat_delete,
            :column => "chat"

  has_flags 1 => :event_read,
            2 => :event_update,
            3 => :event_delete,
            :column => "event"

  has_flags 1 => :merchandise_read,
            2 => :merchandise_update,
            3 => :merchandise_delete,
            :column => "merchandise"

  has_flags 1 => :user_read,
            2 => :user_update,
            3 => :user_delete,
            :column => "user"

  has_flags 1 => :badge_read,
            2 => :badge_update,
            3 => :badge_delete,
            :column => "badge"

  has_flags 1 => :reward_read,
            2 => :reward_update,
            3 => :reward_delete,
            :column => "reward"

  has_flags 1 => :quest_read,
            2 => :quest_update,
            3 => :quest_delete,
            :column => "quest"

  has_flags 1 => :beacon_read,
            2 => :beacon_update,
            3 => :beacon_delete,
            :column => "beacon"

  has_flags 1 => :reporting_read,
            2 => :reporting_update,
            3 => :reporting_delete,
            :column => "reporting"

  has_flags 1 => :interest_read,
            2 => :interest_update,
            3 => :interest_delete,
            :column => "interest"

  def summarize
    perms = {}
    self.flag_columns.each do |c|
      self.as_flag_collection(c, :"#{c}_read", :"#{c}_update", :"#{c}_delete").collect do |o|
        perms[o.first] = o.second
      end
    end
    perms
  end
end
