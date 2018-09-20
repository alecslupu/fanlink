class Person
  module Levels
    def level_earned
      if level_progresses.first.present?
        points = level_progresses.first.total
      else
        points = 0
      end
      if points == 0
        nil
      else
        Level.where(product_id: product.id).where("points <= ?", points).order(points: :desc).first
      end
    end

    def level_earned_from_progresses(progresses)
      if progresses.first.present?
        points = progresses.first.total
      else
        points = 0
      end
      if points == 0
        nil
      else
        Level.where(product_id: product.id).where("points <= ?", points).order(points: :desc).first
      end
    end


    def level
      level_earned.as_json(only: %i[ id name internal_name points ], methods: %i[ picture_url ])
    end
  end
end
