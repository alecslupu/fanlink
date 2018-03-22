class Merchandise < ApplicationRecord
  include AttachmentSupport
  include TranslationThings

  after_save :adjust_priorities

  has_image_called :picture
  has_manual_translated :description, :name

  acts_as_tenant(:product)

  has_paper_trail

  scope :listable, -> { where(available: true) }

private

  def adjust_priorities
    if priority > 0 && saved_change_to_attribute?(:priority)
      same_priority = Merchandise.where.not(id: self.id).where(priority: self.priority)
      if same_priority.count > 0
        Merchandise.where.not(id: self.id).where("priority >= ?", self.priority).each do |m|
          m.increment!(:priority)
        end
      end
    end
  end
end
