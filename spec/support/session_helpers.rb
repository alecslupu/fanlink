module SessionHelpers
  def login_as(person)
    ApplicationController.send :define_method, :current_user do
      person
    end
    @current_user = person
  end

  def create_logged_in_user
    person = FactoryGirl.create(:person)
    login_as(person)
    person
  end

  def logout
    @current_user = nil
    ApplicationController.send :define_method, :current_user do
      nil
    end
  end
end

module Sorcery
  module TestHelpers
    module Rails
      module Integration
        def login_user_post(user, password, product)
          page.driver.post(sessions_url, { email_or_username: user, password: password, product: product })
        end
  
        def logout_user_get
          page.driver.get(logout_url)
        end
      end
    end
  end
end