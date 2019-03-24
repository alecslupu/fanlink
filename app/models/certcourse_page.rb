class CertcoursePage < ApplicationRecord
  belongs_to :certcourse, counter_cache: true

  acts_as_tenant(:product)
  belongs_to :product
  validates_uniqueness_to_tenant :certcourse_page_order, scope: %i[ certcourse_id ]
  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i
  def quiz_type
    [VideoPage, ImagePage, QuizPage].collect {|a| a.model_name.name }
  end

  def media_url
    raise "No longer here"
  end
end
