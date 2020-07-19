# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_certificates
#
#  id                          :bigint           not null, primary key
#  long_name                   :string           not null
#  short_name                  :string           not null
#  description                 :text             default(""), not null
#  certificate_order           :integer          not null
#  color_hex                   :string           default("#000000"), not null
#  status                      :integer          default("entry"), not null
#  room_id                     :integer
#  is_free                     :boolean          default(FALSE)
#  sku_ios                     :string           default(""), not null
#  sku_android                 :string           default(""), not null
#  validity_duration           :integer          default(0), not null
#  access_duration             :integer          default(0), not null
#  certificate_issuable        :boolean          default(FALSE)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  template_image_file_name    :string
#  template_image_content_type :string
#  template_image_file_size    :integer
#  template_image_updated_at   :datetime
#  product_id                  :integer          not null
#


require 'rails_helper'

RSpec.describe Certificate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  # TODO: auto-generated
  describe '#title' do
    it 'works' do
      certificate = build(:certificate)
      expect(certificate.title).to eq(certificate.short_name)
    end
  end
end
