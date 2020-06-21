# frozen_string_literal: true

# == Schema Information
#
# Table name: client_to_people
#
#  id         :bigint(8)        not null, primary key
#  status     :integer          not null
#  client_id  :integer          not null
#  person_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string           not null
#

module Courseware
  module Client
    class ClientToPerson < ApplicationRecord
      has_paper_trail ignore: [:created_at, :updated_at]
      belongs_to :person, class_name: "Person", foreign_key: :person_id  #, touch: true
      belongs_to :client, class_name: "Person", foreign_key: :client_id #, touch: true
      # validates_uniqueness_of :person_id, scope: [:client_id], message: "A user can have only one type of relation to the same client"
      enum status: %i[active terminated]

      validate :check_uniqueness

      after_initialize do
        self.status = 'active'
      end

      private

        # this cannot be done by a validation because a rails error will be thrown and because the first relation will be saved
        # this way a user can see in rails admin what is the issue
        # as we use an STI, if both types of relations are added simultaneously with same client and user, they will come separately so the first one
        # will be saved so we must delete it
        def check_uniqueness
          record = ClientToPerson.find_by(client_id: client_id, person_id: person_id)
          if record.present?
            record.destroy
            errors.add(:person, _("A user can have only one type of relation to the same client"))
          end
        end
    end
  end
end
