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
    class Designated < ClientToPerson

    end
  end
end
