class Event < ApplicationRecord

  validates :name, presence: { message: "Name is required" }
  validates :start_time, presence: { message: "Start time is required" }

end