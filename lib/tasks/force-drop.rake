namespace :db do
  desc "Force a db:drop of database"
  task force_drop: :environment do
    unless Rails.env.production?
      conn = ActiveRecord::Base.connection
      # Terminate all connections except our current one
      conn.execute("SELECT
                      pg_terminate_backend (pid)
                    FROM
                      pg_stat_activity
                    WHERE
                      pid <> pg_backend_pid ()
                    AND datname = 'fanlink_#{Rails.env}';")
      # Close the connection behind us
      ActiveRecord::Base.connection.close
      # Invoke a task now all connections are gone
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:schema:load"].invoke
      p "Forced a db:drop for environment #{Rails.env}"
    else
      p "Sorry I cannot db:drop db on this environment: #{Rails.env}"
    end
  end
end
