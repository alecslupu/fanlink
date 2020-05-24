module ActsAsTaggableOn
  class TagPolicy < ApplicationPolicy

    def history?
      false
    end

    protected

    def module_name
      "root"
    end
  end
end
