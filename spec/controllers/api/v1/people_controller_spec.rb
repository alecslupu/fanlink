require 'rails_helper'

RSpec.describe Api::V1::PeopleController, type: :controller do

  describe "#change_password" do
    it "should change the current users password"
    it "should not change the current users password to one that is too short"
    it "should not change the current users password if wrong password given"
    it "should not change the user password if not logged in"
    it "should not change the password if wrong user id in url"
  end

  describe "#create" do
    it "should sign up new user with email, username, and password, profile fields and send onboarding email"
    it "should sign up new user with FB auth token and send onboarding email"
    it "should sign up new user with FB auth token without email and not send onboarding email"
    it "should not sign up new user if there is a problem with FB"
    it "should not sign up new user with username already used"
    it "should not sign up new user with email already used"
    it "should not sign up new user with email already used"
    it "should not sign up new user without an email"
    it "should not sign up new user with an invalid email"
    it "should not sign up new user without a username"
    it "should not sign up new user with a username less than 3 characters"
    it "should not sign up new user with a username more than 26 characters"
    it "should not sign up new user with an invalid email"
    it "should not sign up new user with FB auth token if account with FB id already exists"
    it "should not sign up new user with FB auth token if account with email already exists"
  end

  describe "#index" do
    it "should not get people if not logged in"
    it "should get all people with no filter"
    it "should page 1 of all people with no filter"
    it "should page 2 of all people with no filter"
    it "should all people using default per page"
    it "should get no people using default per page for page 2"
    it "should get no people with username filter"
    it "should get people with username filter"
    # it "should not return the current user with the username filter"
    it "should get a person with username filter"
    it "should get no people with email filter"
    it "should get people with email filter"
    it "should get a person with email filter"
    it "should people with username and email filter"
    it "should people with username and email filter and paginated"
  end

  describe "#show" do
    it "should get a single person"
    it "should not get person if not logged in"
    it "should return 404 if bad id"
    it "should return 404 if from another product"
  end

  describe "#update" do
    it "should update a person"
    it "should not update a different person by normal person"
    it "should update recommended by admin"
    it "should update recommended by product account"
  end

end
