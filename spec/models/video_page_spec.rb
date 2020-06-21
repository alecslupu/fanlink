# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoPage, type: :model do
  describe '#product' do
    pending
  end

  describe '#set_certcourse_page_duration' do
    let(:duration) { 10 }
    let(:certcourse_page) { create(:certcourse_page, duration: duration + 1) }

    it "changes the duration of the certcourse's page" do
      allow_any_instance_of(described_class).to receive(:video_duration) {
        duration
      }

      create(
        :video_page,
        certcourse_page: certcourse_page,
        product: Product.find(certcourse_page.product_id),
        video: fixture_file_upload(
          Rails.root.join('spec', 'fixtures', 'videos', 'short_video.mp4')
        )
      )

      expect(certcourse_page.duration).to eq(duration)
    end
  end
end
