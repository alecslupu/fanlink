# frozen_string_literal: true

require "rails_helper"

step "A/a category is created" do
  @category = FactoryBot.create(:category)
end

step "A/a category :field is updated with :value" do |field, value|
  @category[field] = value
  @category.save
end

step "A/a category is deleted" do
  @category.destroy
end

step "A/a category is soft deleted" do
  admin = FactoryBot.create(:admin_user)
  login_as(admin)
  delete "/categories/#{@category.id}"
end

step "the category is attached to a post" do
  @post = FactoryBot.create(:post, category: @category)
end

step "the post should not have a category" do
  expect(@post.reload.category_id).to be nil
end

step "category should return deleted as true" do
  expect(@category.reload.deleted).to be true
end

step "category should return nil" do
  expect(@category.reload).to be nil
end
