class CertcoursePage < ApplicationRecord
  belongs_to :certcourse
  has_paper_trail

  def quiz_type
    [VideoPage, ImagePage, QuizPage].collect {|a| a.model_name.name }
  end

  validates_uniqueness_of :certcourse_page_order, scope: %i[ certcourse_id ]

  def product
    @product ||= Product.where(internal_name: "caned").first!
  end
end
