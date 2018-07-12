class AddUuidToExistingSteps < ActiveRecord::Migration[5.1]
  def up
    Step.all.each do |s|
      s.uuid = SecureRandom.uuid
      s.save
    end
  end

  def down
  end
end
