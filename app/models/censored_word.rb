# frozen_string_literal: true

# == Schema Information
#
# Table name: censored_words
#
#  id         :bigint           not null, primary key
#  word       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CensoredWord < ApplicationRecord
end
