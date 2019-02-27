class CertcoursePage < ApplicationRecord
  belongs_to :certcourse

  has_one :quiz_page
  has_one :video_page
  has_one :image_page

  def content_type
  	return 'quiz' if quiz_page.present? 
  	return 'video' if video_page.present?
  	return 'image' if image_page.present?
  end

  def media_url
  	unless quiz_page.present?
  		"media url"
  	else
  		null
  	end
  end
end
