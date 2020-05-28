# == Schema Information
#
# Table name: static_web_contents
#
#  id         :bigint(8)        not null, primary key
#  content    :jsonb            not null
#  title      :jsonb            not null
#  slug       :string           not null
#  product_id :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
module Static
  class WebContent < ApplicationRecord
    has_paper_trail

    translates :title, :content, touch: true, versioning: :paper_trail
    accepts_nested_attributes_for :translations, allow_destroy: true
    belongs_to :product
    acts_as_tenant(:product)

    scope :for_product, -> (product) { where( product_id: product.id ) }

    # validates :title, presence: true
    # validates :content, presence: true
    validates :product_id, presence: true
    validate :title_uniqueness_by_product

    before_save :set_slug

    private

    def set_slug
      self.slug = title.parameterize
    end

    def title_uniqueness_by_product
      errors.add(:title) << 'Title must be unique' if uniq?
    end

    def uniq?
      self.class.where(product: product).where(title: self[:title]).exists?
    end
  end
end
