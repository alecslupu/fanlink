RSpec.describe StaticContent, type: :model do
  before(:all) do
    @product = create(:product)
    ActsAsTenant.current_tenant = @product
    @static_content = create(:static_content)
  end

  context 'Valid factory' do
    it { expect(build(:static_content)).to be_valid }
  end
end
