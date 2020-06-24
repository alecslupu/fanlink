# frozen_string_literal: true

# == Schema Information
#
# Table name: client_infos
#
#  id         :bigint(8)        not null, primary key
#  client_id  :integer          not null
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ClientInfo < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  belongs_to :person, foreign_key: 'client_id'

  validates :client_id, presence: true
  validates :code, presence: true
end
