namespace :delayed_job do


  def args
    fetch(:delayed_job_args, "-e #{fetch(:rails_env)}")
  end

  def delayed_job_roles
    fetch(:delayed_job_server_role, :app)
  end

  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      execute :sudo, :supervisorctl, :stop, :all
    end
  end

# desc 'Stop the delayed_job process'
  # task :stop do
  #   on roles(delayed_job_roles) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :bundle, :exec, :'bin/delayed_job', :stop
  #       end
  #     end
  #   end
  # end
  #

  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      execute :sudo, :supervisorctl, :start, :all
    end
  end

  # desc 'Start the delayed_job process'
  # task :start do
  #   on roles(delayed_job_roles) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :bundle, :exec, :'bin/delayed_job', args, :start
  #       end
  #     end
  #   end
  # end
  #
  desc 'Stop the delayed_job process'
  task :stop do
    on roles(delayed_job_roles) do
      execute :sudo, :supervisorctl, :restart, :all
    end
  end
  # desc 'Restart the delayed_job process'
  # task :restart do
  #   on roles(delayed_job_roles) do
  #     within release_path do
  #       with rails_env: fetch(:rails_env) do
  #         execute :bundle, :exec, :'bin/delayed_job', args, :restart
  #       end
  #     end
  #   end
  # end
end
