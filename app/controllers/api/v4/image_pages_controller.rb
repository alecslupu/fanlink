class Api::V4::ImagePagesController < ApiController
  def create
    @image = ImagePage.create(image_params)
  end

  def image_params
    params.require(:image_page).permit(%i[ certcourse_page_id image ])
  end
end
