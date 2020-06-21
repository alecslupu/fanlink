# frozen_string_literal: true

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
  has_paper_trail

  has_one_attached :template_image

  validates :template_image, size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png]},
            dimension: { width: { min: 3840, max: 3840 },
                         height: { min: 2967, max: 2967 }, message: "Must be 3840x2967" }

  def template_image_url
    template_image.attached? ? [Rails.application.secrets.cloudfront_url, template_image.key].join('/') : nil
  end

  def template_image_optimal_url
    opts = {resize: "1000", auto_orient: true, quality: 75}
    template_image.attached? ? [Rails.application.secrets.cloudfront_url, template_image.variant(opts).processed.key].join('/') : nil
  end

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :room, optional: true

  has_many :certificate_certcourses
  has_many :certcourses, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certificates
  has_many :people, through: :person_certificates, dependent: :destroy

  validates_uniqueness_to_tenant :certificate_order

  validates_format_of :color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  enum status: %i[entry live]
  validates :long_name, :short_name, :description, :certificate_order, :status, :sku_ios, :sku_android, :validity_duration, :access_duration, presence: true

  validates :validity_duration, numericality: { greater_than: 0 }
  validates :access_duration, numericality: { greater_than: 0 }

  validates :certificate_order, numericality: { only_integer: true, greater_than: 0 }
  # validate :certificate_order_validation, if: :certificate_order_changed?

  scope :live_status, -> { where(status: "live") }
  scope :for_product, -> (product) { where(product_id: product.id) }

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
      errors.add(:certificate_order, _("The certificate order must be greater than %{size}. Got %{value}" % { size: certificate_order_max_value, value: certificate_order })) unless certificate_order.to_i >= certificate_order_max_value
    end
end
