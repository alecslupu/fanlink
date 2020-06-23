# frozen_string_literal: true

json.id progress.id
json.reward_id progress.reward_id
json.person_id progress.person_id
json.series progress.series
json.actions progress.actions
json.total @series_total || @progress.total
