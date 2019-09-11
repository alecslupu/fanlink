RSpec.describe StaticContent, type: :model do
  # before(:all) do
  #   @product = create(:product)
  #   ActsAsTenant.current_tenant = @product
  #   @static_content = create(:static_content)
  # end

  describe 'valid factory' do
    it { expect(build(:static_content)).to be_valid }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :product_id }
    it { is_expected.to validate_presence_of :content }

    it 'validates the uniqueness of title' do
      title = 'title'
      create(:static_content, title: title)

      static_content = build(:static_content, title: title)
      static_content.valid?
      expect(static_content.errors.added?(:title, :taken)).to eq(true)
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
