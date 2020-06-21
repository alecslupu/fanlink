# frozen_string_literal: true

RailsAdmin.config do |config|
  config.included_models.push('Referral::ReferredPerson')

  config.model 'Referral::ReferredPerson' do
    list do
      scopes [ nil, :with_transactions ]
      fields :inviter do
        searchable [ :username, referral_user_codes: :unique_code ]
      end
      fields :invited, :created_at

    end
    edit do
    end
    show do
    end
    export do
    end
  end
end
