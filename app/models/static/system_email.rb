# frozen_string_literal: true

module Static
  class SystemEmail < ApplicationRecord
    belongs_to :product
    has_paper_trail

    acts_as_tenant(:product)

    scope :for_product, -> (product) { where(product_id: product.id) }

    translates :html_template, :text_template, :subject, touch: true, versioning: :paper_trail
    accepts_nested_attributes_for :translations, allow_destroy: true

    has_many_attached :images
    has_many_attached :attachments

    before_save :set_slug

    attr_accessor :remove_attachments
    attr_accessor :remove_images

    after_save do
      Array(remove_attachments).each { |id| attachments.find_by_id(id).try(:purge) }
      Array(remove_images).each { |id| images.find_by_id(id).try(:purge) }
    end

    private

    def set_slug
      self.slug = name.parameterize
    end

    def title_uniqueness_by_product
      errors.add(:name) << 'Title must be unique' if uniq?
    end

    def uniq?
      self.class.where(product_id: product_id).where(title: name).exists?
    end
  end
end
