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

  include AttachmentSupport

  has_image_called :template_image

  belongs_to :room, optional: true

  # has_many :certificate_certcourses
  # has_many :certcourses, through: :certificate_certcourses, dependent: :destroy, counter_cache: true

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  validates_uniqueness_to_tenant :certificate_order
  validates_attachment_presence :template_image
  validates_attachment :template_image, dimensions: { height: 2967, width: 3840, message: _('Must be 3840x2967') }

  enum status: %i[entry live]
  # validate :certificate_order_validation, if: :certificate_order_changed?

  scope :live_status, -> { where(status: 'live') }

  def title
    short_name
  end

  def is_paid?
    !is_free?
  end

  def self.certificate_order_max_value
    @maxvalue ||= maximum(:certificate_order).to_i
  end

  def certificate_order_max_value
    self.class.certificate_order_max_value
  end

  private

  def certificate_order_validation
    errors.add(:certificate_order, _('The certificate order must be greater than %{size}. Got %{value}' % { size: certificate_order_max_value, value: certificate_order })) unless certificate_order.to_i >= certificate_order_max_value
  end
end
