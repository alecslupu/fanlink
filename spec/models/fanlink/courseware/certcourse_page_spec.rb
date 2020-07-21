# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_course_pages
#
#  id                   :bigint           not null, primary key
#  course_id            :integer
#  course_page_order    :integer          default(0), not null
#  duration             :integer          default(0), not null
#  background_color_hex :string           default("#000000"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_type         :string
#  product_id           :integer          not null
#


require 'rails_helper'

RSpec.describe Fanlink::Courseware::CoursePage, type: :model do
  context 'Valid factory' do
    it { expect(build(:certcourse_page)).to be_valid }
  end

  describe 'dependencies' do
    it 'destroys dependent quiz page' do
      certcourse_page = create(:certcourse_page)
      quiz_page = create(:quiz_page, course_page: certcourse_page)
      no_of_quiz_answers = quiz_page.answers.count
      expect { certcourse_page.destroy }.to change { Fanlink::Courseware::QuizPage.count }.by(-1)
    end

    #  works locally but fails on pipeline because it does not have FFMPEG
    # it "destroys dependent video page" do
    #   video_page = create(:video_page)

    #   expect { video_page.certcourse_page.destroy }.to change { VideoPage.count }.by(-1)
    # end

    it 'destroys dependent image page' do
      image_page = create(:image_page)
      expect { image_page.course_page.destroy }.to change { Fanlink::Courseware::ImagePage.count }.by(-1)
    end

    it 'destroys dependent download file page' do
      download_file_page = create(:download_file_page)

      expect { download_file_page.course_page.destroy }.to change { Fanlink::Courseware::DownloadFilePage.count }.by(-1)
    end

    it 'destroys dependent course page progresses' do
      certcourse_page = create(:certcourse_page)
      course_page_progress = create(
        :course_page_progress,
        course_page_id: certcourse_page.id,
        person: create(:person)
      )

      expect { course_page_progress.destroy }.to change { Fanlink::Courseware::PersonCoursePageProgress.count }.by(-1)
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
