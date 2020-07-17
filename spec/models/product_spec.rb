# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                   :bigint           not null, primary key
#  name                 :string           not null
#  internal_name        :string           not null
#  enabled              :boolean          default(FALSE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  can_have_supers      :boolean          default(FALSE), not null
#  age_requirement      :integer          default(0)
#  logo_file_name       :string
#  logo_content_type    :string
#  logo_file_size       :integer
#  logo_updated_at      :datetime
#  color_primary        :string           default("4B73D7")
#  color_primary_text   :string           default("FFFFFF")
#  color_secondary      :string           default("CDE5FF")
#  color_secondary_text :string           default("000000")
#  color_tertiary       :string           default("FFFFFF")
#  color_tertiary_text  :string           default("000000")
#  color_accent         :string           default("FFF537")
#  color_accent_text    :string           default("FFF537")
#  color_title_text     :string           default("FFF537")
#  color_accessory      :string           default("000000")
#  navigation_bar_style :integer          default(1)
#  status_bar_style     :integer          default(1)
#  toolbar_style        :integer          default(1)
#  features             :integer          default(0), not null
#  contact_email        :string
#  privacy_url          :text
#  terms_url            :text
#  android_url          :text
#  ios_url              :text
#


RSpec.describe Product, type: :model do
  context 'Validation' do
    it 'should create a valid product' do
      expect(build(:product)).to be_valid
    end
  end

  describe '#destroy' do
    it 'should not let you destroy a product that has people' do
      per = create(:person)
      prod = per.product
      prod.destroy
      expect(prod).to exist_in_database
    end
  end

  describe '#people_count' do
    pending
  end

  describe '#name' do
    it 'should accept a good name format' do
      appl = build(:product, name: 'My App')
      expect(appl).to be_valid
    end
    it 'should not accept a format that is shorter than 3 characters' do
      appl = build(:product, name: 'aa')
      expect(appl).not_to be_valid
      expect(appl.errors[:name]).not_to be_blank
    end
    it 'should not accept a format that is longer than 60 characters' do
      appl = build(:product, name: 'a' * 61)
      expect(appl).not_to be_valid
      expect(appl.errors[:name]).not_to be_blank
    end
    it 'should require unique name' do
      app1 = create(:product, name: 'abc')
      app2 = build(:product, name: 'abc')
      expect(app2).not_to be_valid
      expect(app2.errors[:name]).not_to be_empty
    end
  end

  describe '#internal_name' do
    it 'should accept a good internal name' do
      appl = build(:product, internal_name: 'good_one')
    end
    it 'should not accept an internal name that is shorter than 3 characters' do
      appl = build(:product, internal_name: 'aa')
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it 'should not accept an internal name that is longer than 30 characters' do
      appl = build(:product, internal_name: 'a' * 31)
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it 'should not contain dash' do
      appl = build(:product, internal_name: '-abcd')
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it 'should not contain chars other than alphanumeric or underscore' do
      appl = build(:product, internal_name: 'ab?cd')
      expect(appl).not_to be_valid
      expect(appl.errors[:internal_name]).not_to be_blank
    end
    it 'should require unique internal name' do
      app1 = create(:product, internal_name: 'abc')
      app2 = build(:product, internal_name: 'abc')
      expect(app2).not_to be_valid
      expect(app2.errors[:internal_name]).not_to be_empty
    end
  end

  describe '#to_s' do
    it 'should return the product internal name' do
      prod = build(:product)
      expect(prod.to_s).to eq(prod.internal_name)
    end
  end
end
