# frozen_string_literal: true

json.steps do
  json.array!(@steps) do |step|
    next if step.deleted && current_user.role != 'super_admin'

    json.partial! 'step', locals: { step: step, lang: @lang }
    # unlocks_at = step.unlocks_at || nil
    # # Updates based on current user.
    # if step.step_completed.present?
    #     json.status step.step_completed.status
    #     unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute unless unlocks_at.present?
    # else
    #     json.status step.initial_status
    # end
    # unlocks_at ||= Time.now.to_s
    # if @req_source == "web"
    #     json.delay_unlock step.delay_unlock || 0
    # end
    # json.unlocks_at unlocks_at.to_datetime().utc.iso8601
  end
end
