# frozen_string_literal: true

# == Schema Information
#
# Table name: client_to_people
#
#  id         :bigint           not null, primary key
#  status     :integer          not null
#  client_id  :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string           default("Courseware::Client::Designated"), not null
#

module Courseware
  module Client
    class ClientToPerson < ApplicationRecord
      has_paper_trail
      belongs_to :person, class_name: 'Person', foreign_key: :person_id #, touch: true
      belongs_to :client, class_name: 'Person', foreign_key: :client_id #, touch: true

      enum status: %i[active terminated]

      after_initialize do
        self.status = 'active'
      end
    end
  end
end
