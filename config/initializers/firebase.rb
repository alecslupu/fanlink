# frozen_string_literal: true

secrets = Rails.application.secrets
FIREBASE_URL = secrets.firebase_url || (abort 'You need to set FIREBASE_URL')
FIREBASE_KEY = secrets.firebase_key || File.read(ENV['FIREBASE_JSON_FILE']) || (abort 'You need to set FIREBASE_KEY')
FIREBASE_CM_KEY = secrets.firebase_cm_key || (abort 'You need to set the FIREBASE_CM_KEY')
