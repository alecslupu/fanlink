# frozen_string_literal: true

# == Schema Information
#
# Table name: message_mentions
#
#  id         :bigint           not null, primary key
#  message_id :integer          not null
#  person_id  :integer          not null
#  location   :integer          default(0), not null
#  length     :integer          default(0), not null
#

class MessageMention < ApplicationRecord
  validates :person_id, presence: true

  belongs_to :message, touch: true
  belongs_to :person, touch: true
end
