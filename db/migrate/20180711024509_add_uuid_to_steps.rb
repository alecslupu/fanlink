class AddUuidToSteps < ActiveRecord::Migration[5.1]
  def change
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
    add_column :steps, :uuid, :uuid, default: 'gen_random_uuid()'
  end
end
