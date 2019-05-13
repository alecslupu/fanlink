# == Schema Information
#
# Table name: certificates
#
#  id                          :bigint(8)        not null, primary key
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

class Certificate < ApplicationRecord
  include AttachmentSupport

  has_image_called :template_image

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  validates_uniqueness_to_tenant :certificate_order
  validates_attachment_presence :template_image
  validates_attachment :template_image, dimensions: { height: 2967, width: 3840, message: _("Must be 3840x2967") }

  validates_format_of :color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  enum status: %i[entry live]
  validates :long_name, :short_name, :description, :certificate_order, :status, :sku_ios, :sku_android, :validity_duration, :access_duration, presence: true

  validates :validity_duration, numericality: { greater_than: 0 }
  validates :access_duration, numericality: { greater_than: 0 }

  validates :certificate_order, numericality: { only_integer: true, greater_than: 0 }
  validate :certificate_order_validation

  scope :live_status, -> { where(status: "live") }

  def title
    short_name
  end

  private
  def certificate_order_validation
    maxvalue = self.class.where(product_id: self.product_id).maximum(:certificate_order).to_i
    errors.add(:certificate_order, _("The certificate order must be greater than %{size}. Got %{value}" % { size: maxvalue, value: maxvalue })) unless certificate_order.to_i >= maxvalue
  end
end
