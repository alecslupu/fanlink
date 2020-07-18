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
      allow_any_instance_of(described_class).to receive(:duration) { duration }

      ActsAsTenant.with_tenant(certcourse_page.product) do
        VideoPage.create(
          certcourse_page: certcourse_page,
          video: fixture_file_upload(
            Rails.root.join('spec', 'fixtures', 'videos', 'short_video.mp4')
          )
        )
      end

      expect(certcourse_page.duration).to eq(duration)
    end
  end
end
