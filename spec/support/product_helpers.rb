module ProductHelpers
  def current_product
    ActsAsTenant.current_tenant || Product.first || FactoryBot.create(:product)
  end
end

FactoryBot::SyntaxRunner.send(:include, ProductHelpers) # to use in factory