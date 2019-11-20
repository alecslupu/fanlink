#!/usr/bin/env ruby
require "thor"
require "open3"

class Deploy < Thor
  desc "deploy BRANCH DESTINATION", "deploy a branch to a heroku destination"

  def deploy(branch, dest)
    say "Attempting to put #{branch} on #{dest}", :yellow

    current = `git rev-parse --abbrev-ref HEAD`.chomp

    if dest == "staging"
      say "This deploy script has been deprecated.", :red
      say "Internally invoking ", :green
      say " cap staging deploy ", :yellow
      say " ", :yellow
      Open3.popen2(*%w[cap staging deploy]) do |input, output, _|
        input.close
        output.each { |line| puts line }
      end
      exit
    end

    if current != branch
      say "Not on the branch #{branch}.  Switch away from #{current}", :red
      exit
    end

    if branch == "master" || branch == "staging"
      say "Generating docs for #{branch}", :blue
      `git --git-dir ../apidocs/.git checkout #{branch}`
      `bin/docapi`
      `git --git-dir ../apidocs/.git add .`
      `git --git-dir ../apidocs/.git commit -m 'doc update'`
      `git --git-dir ../apidocs/.git push origin #{branch}`
    end

    if !(`git remote | sort | uniq`.match(dest))
      say "Don't see #{dest} in the list of remotes.", :red
      exit
    end

    say "Ensuring we are up to date.", :blue
    `git pull origin #{branch}`

    say "Make a bundle", :blue
    `bundle`

    say "git push -f #{dest} #{branch}:master", :yellow
    `git push -f #{dest} #{branch}:master`

    say "Running Migrations", :blue
    Open3.popen2(*%w[heroku run rails db:migrate -r], dest) do |input, output, _|
      input.close
      output.each { |line| puts line }
    end
  end
end

Deploy.start
