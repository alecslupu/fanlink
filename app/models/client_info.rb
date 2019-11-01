# == Schema Information
#
# Table name: client_infos
#
#  id           :bigint(8)        not null, primary key
#  client_id    :integer          not_null
#  info         :string           not null
#

class ClientInfo < ApplicationRecord
  belongs_to :person

  validates :client_id, presence: true
  validates :code, presence: true
end
