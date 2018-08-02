json.steps do
    json.array!(@steps) do |step|
<<<<<<< HEAD
        next if step.deleted && current_user.role != 'super_admin'
        json.cache! ['v3', step, @lang] do
            json.partial! "step", locals: { step: step, lang: @lang }
        end
        # unlocks_at = step.unlocks_at || nil
        # # Updates based on current user.
        # if step.step_completed.present?
        #     json.status step.step_completed.status
        #     unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute unless unlocks_at.present?
        # else
        #     json.status step.initial_status
        # end
        # unlocks_at ||= Time.now.to_s
        # if current_user.app == "portal"
        #     json.delay_unlock step.delay_unlock || 0
        # end
        # json.unlocks_at unlocks_at.to_datetime().utc.iso8601
=======
      next if step.deleted && current_user.role != "super_admin"
      json.cache! ["v3", step, @lang] do
        json.partial! "step", locals: { step: step, lang: @lang }
      end
      unlocks_at = step.unlocks_at || nil
      # Updates based on current user.
      if step.step_completed.present?
        json.status step.step_completed.status
        unlocks_at = step.step_completed.created_at.to_datetime.utc + step.delay_unlock.minute unless unlocks_at.present?
      else
        json.status step.initial_status
      end
      unlocks_at ||= Time.now.to_s
      if current_user.app == "portal"
        json.delay_unlock step.delay_unlock || 0
      end
      json.unlocks_at unlocks_at.to_datetime().utc.iso8601
>>>>>>> 2bb822c0cb41b2830f4d0c42a8ff7f1a5679bc7c
    end
  end
