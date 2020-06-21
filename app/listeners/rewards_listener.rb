# frozen_string_literal: true

class RewardsListener
  include RealTimeHelpers

  def self.reward_progress_created(user, progress, series_total = nil)
    series_total = progress.total if series_total.blank?
    if series_total >= progress.reward.completion_requirement
      rewarded = PersonReward.where(person_id: user.id, reward_id: progress.reward.id, source: "reward")
      if !rewarded.exists?
        reward = PersonReward.create(person_id: user.id, reward_id: progress.reward.id, source: "reward")
        if reward.valid?
          reward.save
          if progress.reward.points > 0
            LevelsListener.award_points(user, "points" => progress.reward.points, "source" => progress.reward.reward_type)
          end
        end
      end
    end
    user.touch
  end

  def self.create_quest_completed_successful(completed)
    if completed.quest.rewards.present?
      completed.quest.rewards.each do |reward|
        reward = PersonReward.find_or_initialize_by(person_id: completed.person_id, reward_id: reward.id, source: "quest_reward")
        if reward.valid?
          reward.save
          Rails.logger.tagged("[Rewards Quest Completed") { Rails.logger.info "Awarded reward for Quest: #{completed.quest_id} User: #{completed.person_id} Reward: #{reward.id}" } unless Rails.env.production?
        else
          Rails.logger.tagged("[Rewards Quest Completed") { Rails.logger.error "Failed to save awarded reward for Quest: #{completed.quest_id} User: #{completed.person_id} Reward: #{reward.id}" } unless Rails.env.production?
        end
      end
    end
  end
  def self.create_step_completed_successful(completed)
    if completed.step.rewards.present?
      completed.step.rewards.each do |reward|
        reward = PersonReward.find_or_initialize_by(person_id: completed.person_id, reward_id: reward.id, source: "step_reward")
        if reward.valid?
          reward.save
          Rails.logger.tagged("[Rewards Step Completed") { Rails.logger.info "Awarded reward for Quest: #{completed.quest_id} Step: #{completed.step_id} User: #{completed.person_id} Reward: #{reward.id}" } unless Rails.env.production?
        else
          Rails.logger.tagged("[Rewards Step Completed") { Rails.logger.error "Failed to save awarded reward for Quest: #{completed.quest_id} Step: #{completed.step_id} User: #{completed.person_id} Reward: #{reward.id}" } unless Rails.env.production?
        end
      end
    end
  end
end
