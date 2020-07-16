class ResetCountersOnInterest < ActiveRecord::Migration[6.0]
  def up
    Interest.find_each do |interest|
      Interest.reset_counters(interest.id, :children)
    end
  end

  def down
  end
end
