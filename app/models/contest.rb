class Contest < ApplicationRecord
  normalize_attributes :rules_url, :contest_url
end
