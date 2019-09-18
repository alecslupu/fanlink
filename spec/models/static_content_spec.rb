RSpec.describe StaticContent, type: :model do
  describe 'valid factory' do
    it { expect(build(:static_content)).to be_valid }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :content }

    it 'validates the uniqueness of title' do
      title = 'title'
      create(:static_content, title: title)

      static_content = build(:static_content, title: title)
      static_content.valid?

      expect(static_content.errors[:title]).to include('Title must be unique')
    end
  end

  describe '#set_slug' do
    it 'automatically adds the slug based on the title' do
      title = 'title'
      static_content = create(:static_content, title: title)

      expect(static_content.slug).to eq(title.parameterize)
    end
  end
end
