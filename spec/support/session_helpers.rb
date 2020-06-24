# frozen_string_literal: true

module SessionHelpers
  def login_as(person)
    raise 'You need to provide a Person object' unless person.is_a?(Person)

    @controller.auto_login(person) if defined?(@controller)
  end

  def create_logged_in_user
    person = FactoryGirl.create(:person)
    login_as(person)
    person
  end

  def logout
    if defined?(@controller)
      @controller.send(:reset_session)
      @controller.logout
    end

    # ApplicationController.send :define_method, :current_user do
    #   nil
    # end
  end
end

module Sorcery
  module TestHelpers
    module Rails
      module Integration
        def login_user_post(user, password, product)
          page.driver.post(sessions_url, email_or_username: user, password: password, product: product)
        end

        def logout_user_get
          page.driver.get(logout_url)
        end
      end
    end
  end
end
