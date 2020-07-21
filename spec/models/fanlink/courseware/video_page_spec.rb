# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_video_pages
#
#  id                 :bigint           not null, primary key
#  course_page_id     :integer
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
  describe '#set_certcourse_page_duration' do
    let(:duration) { 10 }
    let(:certcourse_page) { create(:certcourse_page, duration: duration + 1) }

    it "changes the duration of the certcourse's page" do
      allow_any_instance_of(described_class).to receive(:duration) { duration }

      ActsAsTenant.with_tenant(certcourse_page.product) do
        VideoPage.create(
          course_page: certcourse_page,
          video: fixture_file_upload(
            Rails.root.join('spec', 'fixtures', 'videos', 'short_video.mp4')
          )
        )
      end

      expect(certcourse_page.duration).to eq(duration)
    end
  end
end
