require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do

  describe "#create" do
    it "should create a new post and publish it"
    it "should create a new post and publish it with a lot of fields normal users really should not have access to but i am told they should"
    it "should allow admin to create recommended post"
    it "should not allow non admin to create recommended post"
    it "should create a new post and publish it with a lot of fields normal users really should not have access to but i am told they should"
    it "should allow admin to create recommended post"
    it "should not allow non admin to create recommended post"
    it "should not create a new post if not logged in"
  end

  describe "#destroy" do
    it "should delete message from original creator"
    it "should not delete post from someone else"
    it "should not delete post if not logged in"
  end

  describe "#index" do
    it "should get a list of posts for a date range without limit"
    it "should get a list of posts for a date range with limit"
    it "should not include posts from blocked person"
    it "should return correct language if device language provided"
    it "should not get the list if not logged in"
    it "should return unprocessable if invalid from date"
    it "should return unprocessable if invalid to date"
    it "should return unprocessable if missing dates"
    it "should return unprocessable if missing from date"
    it "should return unprocessable if missing to date"
    it "should get a list of posts for a person"
    it "should return unprocessable for a badly formed person id"
    it "should return unprocessable for a nonexistent person"
  end

  describe "#list" do
    it "should get the list of all posts unfiltered"
    it "should get the list of all posts unfiltered"
    it "should get list paginated at page 1"
    it "should get list paginated at page 2"
    it "should get the list of all posts filtered on person_id"
    it "should get the list of all posts filtered on full person username match"
    it "should get the list of all posts filtered on partial person username match"
    it "should get the list of all posts filtered on full person email match"
    it "should get the list of all posts filtered on partial person email match"
    it "should get the list of all posts filtered on full body match"
    it "should get the list of all posts filtered on partial body match"
    it "should get the list of all posts posted at or after some time matching all"
    it "should get the list of all posts posted at or after some time matching some"
    it "should get the list of all posts posted at or before some time matching all"
    it "should get the list of all posts posted on or after some time matching some"
    it "should get the list of all posts matching a status"
    it "should get a list of posts filtered on body and posted_after"
    it "should give you a single post filtered on post id"
    it "should not give you anything if not logged in"
    it "should not give you anything if logged in as normal"
  end

  describe "#show" do
    it "should get a visible post"
    it "should get a visible post with reaction counts"
    it "should include current user reaction"
    it "should return english language body if no device language provided and english exists"
    it "should return original language body if no device language provided and no english exists"
    it "should return correct language body if device language provided"
    it "should get a visible post with reaction counts"
    it "should include current user reaction"
    it "should not get a deleted post"
    it "should not get a rejected post"
    it "should get a post with a start date and no end date"
    it "should get an unexpired post with no start date and an end date"
    it "should get an unexpired post with both dates"
    it "should not get a premature post with a start date and no end date"
    it "should not get an expired post with no start date and an end date"
    it "should not get a premature post with both dates"
    it "should not get an expired post with both dates"
  end

  describe "#share" do
    it "should get a post without authentication"
    it "should 404 with valid post in different product"
    it "should 404 with invalid post id"
    it "should 422 with invalid product"
    it "should 422 with missing product"
    it "should get a post for different product than logged in"
    it "should 404 on an unpublished post"
  end

  describe "#update" do
    it "should let admin update a post"
    it "should not let not logged in update a post"
    it "should not let normal user update recommended"
    it "should let product account update recommended"
  end
end
