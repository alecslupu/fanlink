# frozen_string_literal: true
# == Schema Information
#
# Table name: levels
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  name_text_old        :text
#  internal_name        :text             not null
#  points               :integer          default(1000), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  description          :jsonb            not null
#  name                 :jsonb            not null
#

class Level < ApplicationRecord
  include AttachmentSupport

  has_paper_trail

  acts_as_tenant(:product)
  belongs_to :product

  has_image_called :picture
  # has_manual_translated :description, :name

  scope :for_product, -> (product) { where( levels: { product_id: product.id } ) }

  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  validates :internal_name,
            presence: { message: _("Internal name is required.") },
            format: { with: /\A[a-z_0-9]+\z/, message: lambda { |*| _("Internal name can only contain lowercase letters, numbers and underscores.") } },
            length: { in: 3..26, message: _("Internal name must be between 3 and 26 characters in length.") },
            uniqueness: { scope: :product_id, message: _("There is already a level with that internal name.") }

  validates :points, presence: { message: _("Point value is required.") },
            numericality: { greater_than: 0, message: _("Point value must be greater than zero.") },
            uniqueness: { scope: :product_id, message: _("There is already a level with that point value.") }
end
