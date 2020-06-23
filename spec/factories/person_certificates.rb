# frozen_string_literal: true

# == Schema Information
#
# Table name: person_certificates
#
#  id                                    :bigint(8)        not null, primary key
#  person_id                             :integer          not null
#  certificate_id                        :integer          not null
#  full_name                             :string           default(""), not null
#  issued_date                           :datetime
#  validity_duration                     :integer          default(0), not null
#  amount_paid                           :bigint(8)        default(0), not null
#  currency                              :string           default(""), not null
#  fee_waived                            :boolean          default(FALSE)
#  purchased_waived_date                 :datetime
#  access_duration                       :integer          default(0), not null
#  purchased_order_id                    :string
#  purchased_platform                    :integer          default("ios"), not null
#  purchased_sku                         :string
#  unique_id                             :string
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  issued_certificate_image_file_name    :string
#  issued_certificate_image_content_type :string
#  issued_certificate_image_file_size    :integer
#  issued_certificate_image_updated_at   :datetime
#  issued_certificate_pdf_file_name      :string
#  issued_certificate_pdf_content_type   :string
#  issued_certificate_pdf_file_size      :integer
#  issued_certificate_pdf_updated_at     :datetime
#  receipt_id                            :string
#  is_completed                          :boolean          default(FALSE)
#

FactoryBot.define do
  factory :person_certificate do
    person { create(:person) }
    certificate { create(:certificate) }
    issued_certificate_image { File.open("#{Rails.root}/spec/fixtures/images/large.jpg") }
    issued_certificate_pdf { File.open("#{Rails.root}/spec/fixtures/pdfs/dummy.pdf") }

  end
end
