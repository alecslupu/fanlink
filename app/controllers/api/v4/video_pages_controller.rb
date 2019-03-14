class Api::V4::VideoPagesController < ApiController
  def create
  	@image = VideoPage.create(video_params)
  end

  def video_params
    params.require(:video_page).permit(%i[ certcourse_page_id video ])
  end
end
