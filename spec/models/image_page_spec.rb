# frozen_string_literal: true

# == Schema Information
#
# Table name: image_pages
#
#  id                 :bigint           not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer          not null
#


require 'rails_helper'

RSpec.describe ImagePage, type: :model do
  context 'Valid' do
    it { expect(build(:image_page)).to be_valid }
  end

  pending "add some examples to (or delete) #{__FILE__}"

  # TODO: auto-generated
  describe '#product' do
    pending
  end
end
