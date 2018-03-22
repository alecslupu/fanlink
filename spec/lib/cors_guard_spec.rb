describe ".allow_from?" do

  before(:each) do
    Rails.cache.delete(CorsGuard::CORS_KEY)
  end

  it "should always allow from www.fan.link" do
    expect(CorsGuard.allow_from?("https://www.fan.link")).to be_truthy
  end

  it "should not allow from somewhere else" do
    expect(CorsGuard.allow_from?("https://www.example.com")).to be_falsey
  end

  it "should allow from product" do
    product = create(:product, enabled: true)
    expect(CorsGuard.allow_from?("https://#{product.internal_name}.fan.link")).to be_truthy
  end

  it "should not allow from disabled product" do
    product = create(:product, enabled: false)
    expect(CorsGuard.allow_from?("https://#{product.internal_name}.fan.link")).to be_falsey
  end
end
