# frozen_string_literal: true

# == Schema Information
#
# Table name: download_file_pages
#
#  id                    :bigint           not null, primary key
#  certcourse_page_id    :bigint
#  product_id            :bigint
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  caption               :text
#


require 'rails_helper'

RSpec.describe DownloadFilePage, type: :model do
  context 'Validation' do
    describe 'should create a valid course' do
      it { expect(build(:download_file_page)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
