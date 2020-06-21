# frozen_string_literal: true

# == Schema Information
#
# Table name: censored_words
#
#  id         :bigint(8)        not null, primary key
#  word       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CensoredWord < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

end
