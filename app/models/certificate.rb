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

class Certificate < Fanlink::Courseware::Certificate

  self.table_name = :courseware_certificates

  def template_image_url
    ActiveSupport::Deprecation.warn("Certificate#issued_certificate_image_url is deprecated")
    AttachmentPresenter.new(template_image).url
  end

  def template_image_optimal_url
    ActiveSupport::Deprecation.warn("Certificate#template_image_optimal_url is deprecated")
    AttachmentPresenter.new(template_image).optimal_url
  end

  belongs_to :room, optional: true

  # has_many :certificate_certcourses
  # has_many :certcourses, through: :certificate_certcourses, dependent: :destroy, counter_cache: true

  # has_many :person_certificates
  # has_many :people, through: :person_certificates, dependent: :destroy

  # validate :certificate_order_validation, if: :certificate_order_changed?

  def self.certificate_order_max_value
    @maxvalue ||= maximum(:certificate_order).to_i
  end

  def certificate_order_max_value
    self.class.certificate_order_max_value
  end

  private

  def certificate_order_validation
    errors.add(:certificate_order, _('The certificate order must be greater than %{size}. Got %{value}' % {size: certificate_order_max_value, value: certificate_order})) unless certificate_order.to_i >= certificate_order_max_value
  end
end
