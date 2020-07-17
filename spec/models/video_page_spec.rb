# frozen_string_literal: true

# == Schema Information
#
# Table name: video_pages
#
#  id                 :bigint           not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  video_file_name    :string
#  video_content_type :string
#  video_file_size    :integer
#  video_updated_at   :datetime
#  product_id         :integer          not null
#


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
