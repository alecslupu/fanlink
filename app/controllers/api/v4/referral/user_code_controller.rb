# frozen_string_literal: true

module Api
  module V4
    module Referral
      class UserCodeController < ApiController
        def index
          @referral_code = current_user.find_or_create_referral_code
          return_the @referral_code, handler: :jb
        end
      end
    end
  end
end
