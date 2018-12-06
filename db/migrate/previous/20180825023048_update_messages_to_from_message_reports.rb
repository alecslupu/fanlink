class UpdateMessagesToFromMessageReports < ActiveRecord::Migration[5.1]
  def change
    MessageReport.includes([:message]).all.each do |mr|
      if mr.status.to_s == "no_action_needed"
        mr.message.status = Message.statuses[:posted]
        mr.message.save
      end
    end
  end
end
