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
      belongs_to :person, class_name: 'Person' # , touch: true
      belongs_to :client, class_name: 'Person' # , touch: true

      enum status: { active: 0, terminated: 1 }

      after_initialize do
        self.status = 'active'
      end
    end
  end
end
