# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CertcoursePage, type: :model do
  context 'Valid factory' do
    it { expect(build(:certcourse_page)).to be_valid }
  end

  describe 'dependencies' do
    it 'destroys dependent quiz page' do
      certcourse_page = create(:certcourse_page)
      quiz_page = create(:quiz_page, certcourse_page: certcourse_page)
      no_of_quiz_answers = quiz_page.answers.count

      expect { certcourse_page.destroy }.to change { QuizPage.count }.by(-1)
    end

    #  works locally but fails on pipeline because it does not have FFMPEG
    # it "destroys dependent video page" do
    #   video_page = create(:video_page)

    #   expect { video_page.certcourse_page.destroy }.to change { VideoPage.count }.by(-1)
    # end

    it 'destroys dependent image page' do
      image_page = create(:image_page)

      expect { image_page.certcourse_page.destroy }.to change { ImagePage.count }.by(-1)
    end

    it 'destroys dependent download file page' do
      download_file_page = create(:download_file_page)

      expect { download_file_page.certcourse_page.destroy }.to change { DownloadFilePage.count }.by(-1)
    end

    it 'destroys dependent course page progresses' do
      certcourse_page = create(:certcourse_page)
      course_page_progress = create(
        :course_page_progress,
        certcourse_page_id: certcourse_page.id,
        person: create(:person)
      )

      expect { course_page_progress.destroy }.to change { CoursePageProgress.count }.by(-1)
    end
  end

  # TODO: auto-generated
  describe '#content_type' do
    pending
  end

  # TODO: auto-generated
  describe '#media_url' do
    pending
  end

  # TODO: auto-generated
  describe '#child' do
    pending
  end
end
