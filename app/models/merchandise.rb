# frozen_string_literal: true
# == Schema Information
#
# Table name: merchandise
#
#  id                   :bigint(8)        not null, primary key
#  product_id           :integer          not null
#  name_text_old        :text
#  description_text_old :text
#  price                :text
#  purchase_url         :text
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  available            :boolean          default(TRUE), not null
#  name                 :jsonb            not null
#  description          :jsonb            not null
#  priority             :integer          default(0), not null
#  deleted              :boolean          default(FALSE), not null
#

class Merchandise < ApplicationRecord

  after_save :adjust_priorities

  # AttachmentSupport
  # has_attached_file :picture,
  #                   default_url: nil,
  #                   styles: {
  #                     optimal: "1000x",
  #                     thumbnail: "100x100#"
  #                   },
  #                   convert_options: {
  #                     optimal: "-quality 75 -strip"
  #                   }
  #
  # validates_attachment :picture,
  #                      content_type: {content_type: %w[image/jpeg image/gif image/png]},
  #                      size: {in: 0..5.megabytes}
  #
  # def picture_url
  #   picture.file? ? picture.url : nil
  # end
  #
  # def picture_optimal_url
  #   picture.file? ? picture.url(:optimal) : nil
  # end

  has_one_attached :picture

  validates :picture, size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png]}

  def picture_url
    picture.attached? ? service_url : nil
  end

  def picture_optimal_url
    opts = {resize_to_limit: [1000, 5000], auto_orient: true, quality: 75}
    picture.attached? ? picture.variant(opts).processed.service_url : nil
  end

  # AttachmentSupport
  translates :description, :name, touch: true, versioning: :paper_trail
  accepts_nested_attributes_for :translations, allow_destroy: true

  acts_as_tenant(:product)
  belongs_to :product

  normalize_attribute :price, with: :currency

  has_paper_trail

  scope :listable, -> { where(available: true) }

  # TODO Translate returned error messages
  # validates :name, presence: { message: _("Name is required.") }
  # validates :description, presence: { message: _("Description is required.") }

private

  def adjust_priorities
    if priority > 0 && saved_change_to_attribute?(:priority)
      same_priority = Merchandise.where.not(id: self.id).where(priority: self.priority)
      if same_priority.count > 0
        Merchandise.where.not(id: self.id).where("priority >= ?", self.priority).each do |merchandise|
          merchandise.increment!(:priority)
        end
      end
    end
  end
end
