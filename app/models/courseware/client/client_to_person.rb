# == Schema Information
#
# Table name: client_to_people
#
#  id                 :bigint(8)        not null, primary key
#  status             :integer          not null
#  relation_type      :integer          not null
#  client_id          :integer          not null, foreign key
#  person_id          :integer          not null, foreign key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

module Courseware
  module Client
    class ClientToPerson < ApplicationRecord
      has_paper_trail
      belongs_to :person, class_name: "Person", foreign_key: :person_id
      belongs_to :person, class_name: "Person", foreign_key: :client_id

      enum status: %i[active terminated]
      enum relation_type: %i[assigned designated]
      end
    end
  end
end
