# frozen_string_literal: true

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
