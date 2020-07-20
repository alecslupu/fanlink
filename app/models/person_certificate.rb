# frozen_string_literal: true

# == Schema Information
#
# Table name: person_certificates
#
#  id                                    :bigint           not null, primary key
#  person_id                             :integer          not null
#  certificate_id                        :integer          not null
#  full_name                             :string           default(""), not null
#  issued_date                           :datetime
#  validity_duration                     :integer          default(0), not null
#  amount_paid                           :bigint           default(0), not null
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
#  issued_certificate_image_conull: false, default: 0ntent_type :string
#  issued_certificate_image_file_size    :integer
#  issued_certificate_image_updated_at   :datetime
#  issued_certificate_pdf_file_name      :string
#  issued_certificate_pdf_content_type   :string
#  issued_certificate_pdf_file_size      :integer
#  issued_certificate_pdf_updated_at     :datetime
#  receipt_id                            :string
#  is_completed                          :boolean          default(FALSE)
#

class PersonCertificate < Fanlink::Courseware::PersonCertificate
  def issued_certificate_image_url
    ActiveSupport::Deprecation.warn("PersonCertificate#issued_certificate_image_url is deprecated")
    AttachmentPresenter.new(issued_certificate_image).url
  end

  def issued_certificate_pdf_url
    ActiveSupport::Deprecation.warn("PersonCertificate#issued_certificate_pdf_url is deprecated")
    AttachmentPresenter.new(issued_certificate_pdf).url
  end

  scope :for_android, ->(person) { where(person_id: person.id, purchased_platform: 'android') }
  scope :for_ios, ->(person) { where(person_id: person.id, purchased_platform: 'ios') }
end
