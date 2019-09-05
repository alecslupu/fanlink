require 'rails_helper'

RSpec.describe VideoPage, type: :model do
  describe '#product' do
    pending
  end

  describe '#set_certcourse_page_duration' do
    let(:certcourse_page) { create(:certcourse_page, duration: 300) }

    it 'changes the duration of the page' do
      video_page = create(
        :video_page,
        certcourse_page: certcourse_page,
        product: Product.find(certcourse_page.product_id),
        video: fixture_file_upload(
          Rails.root.join('spec', 'fixtures', 'videos', 'short_video.mp4')
        )
      )
      duration = FFMPEG::Movie.new(
        Paperclip.io_adapters.for(video_page.video).path
      ).duration.to_i + 1
      expect(certcourse_page.duration).to eq(duration)
    end
  end
end
