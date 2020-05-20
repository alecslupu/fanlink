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
  include AttachmentSupport
  include TranslationThings

  after_save :adjust_priorities

  has_image_called :picture
  has_manual_translated :description, :name

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
