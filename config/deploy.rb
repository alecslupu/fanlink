# config valid for current version and patch releases of Capistrano
lock "~> 3.11.1"

set :application, "flapi"
set :repo_url, "git@gitlab.fan.link:fanlink/fanlink.git"

set :deploy_via, :remote_cache
set :deploy_to, "/home/ubuntu/sites/#{fetch(:application)}"

set :keep_releases, 5

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :linked_files, fetch(:linked_files, []).push("config/secrets.yml", "config/database.yml")
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads")

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

set :puma_preload_app, true
set :puma_init_active_record, true
set :puma_plugins, [:tmp_restart] # accept array of plugins

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
set :ssh_options, {
  keys: %w[~/.ssh/id_rsa],
  forward_agent: false,
  # auth_methods: %w[password]
}

set :slackistrano, {
  klass: Slackistrano::CustomMessaging,
  channel: "#bot-deploys",
  webhook: "https://hooks.slack.com/services/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",
}

append :linked_dirs, "tmp/pids"
set :delayed_job_server_role, :worker
set :delayed_job_args, "-n 2"

# deploy
#   deploy:starting
#     [before]
#       deploy:ensure_stage
#       deploy:set_shared_assets
#     deploy:check
#   deploy:started
#   deploy:updating
#     git:create_release
#     deploy:symlink:shared
#   deploy:updated
#     [before]
#       deploy:bundle
#     [after]
#       deploy:migrate
#       deploy:compile_assets
#       deploy:normalize_assets
#   deploy:publishing
#     deploy:symlink:release
#   deploy:published
#   deploy:finishing
#     deploy:cleanup
#   deploy:finished
#     deploy:log_revision

# after 'deploy:check', 'delayed_job:restart'

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }
after "deploy:finished", "delayed_job:restart"
