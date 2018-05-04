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
