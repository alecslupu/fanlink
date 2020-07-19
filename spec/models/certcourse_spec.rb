# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_courses
#
#  id                     :bigint           not null, primary key
#  long_name              :string           not null
#  short_name             :string           not null
#  description            :text             default(""), not null
#  color_hex              :string           default("#000000"), not null
#  status                 :integer          default("entry"), not null
#  duration               :integer          default(0), not null
#  is_completed           :boolean          default(FALSE)
#  copyright_text         :text             default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  product_id             :integer          not null
#  certcourse_pages_count :integer          default(0)
#


require 'rails_helper'

RSpec.describe Certcourse, type: :model do
  context 'Valid factory' do
    it { expect(create(:certcourse)).to be_valid }
  end
  describe 'dependencies' do
    it 'destroys dependent certcourse page' do
      certcourse_page = create(:certcourse_page)
      expect { certcourse_page.certcourse.destroy }.to change { CertcoursePage.count }.by(-1)
    end
  end
end
