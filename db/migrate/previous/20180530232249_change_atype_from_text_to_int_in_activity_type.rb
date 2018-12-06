class ChangeAtypeFromTextToIntInActivityType < ActiveRecord::Migration[5.1]
  def change
    rename_column :activity_types, :atype, :atype_old
    add_column :activity_types, :atype, :integer, default: 0, null: false
    #enum atype: %i[ beacon image audio post activity_code ] 
    ActivityType.all.each do |at|
      if at.atype_old.present?
        if at.atype_old == "beacon"
          at.atype = 0
          at.save
        elsif at.atype_old == "image"
          at.atype = 1
          at.save
        elsif at.atype_old == "audio"
          at.atype = 2
          at.save
        elsif at.atype_old == "post"
          at.atype = 3
          at.save
        elsif at.atype_old == "activity_code"
          at.atype = 4
          at.save
        end
      end
    end
  end
end
