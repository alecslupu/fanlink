# frozen_string_literal: true

module DateUtil
  # check if date is valid in format YYYY-MM-DD
  def self.valid_date_string?(s)
    y, m, d = s.split('-').map { |i| i.to_i }
    return false unless y > 2016 && y < 2025
    Date.valid_date?(y, m.to_i, d.to_i)
  end
end
