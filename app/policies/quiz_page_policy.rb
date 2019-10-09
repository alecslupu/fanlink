class QuizPagePolicy < CoursewarePolicy
  class Scope < Scope
    def resolve
      super.for_product(ActsAsTenant.current_tenant).includes(certcourse_page: :certcourse)
    end
  end
end
