# frozen_string_literal: true

# == Schema Information
#
# Table name: level_progresses
#
#  id        :bigint           not null, primary key
#  person_id :integer          not null
#  points    :jsonb            not null
#  total     :integer          default(0), not null
#

class LevelProgress < ApplicationRecord
  belongs_to :person, touch: true
end
