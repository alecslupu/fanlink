# frozen_string_literal: true

# == Schema Information
#
# Table name: static_system_emails
#
#  id         :bigint           not null, primary key
#  name       :string
#  product_id :bigint
#  public     :boolean          default(FALSE)
#  from_name  :string
#  from_email :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'rails_helper'

RSpec.describe Static::SystemEmail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
