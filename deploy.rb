#!/usr/bin/env ruby
require "thor"
require "open3"

class Deploy < Thor
  desc "deploy BRANCH DESTINATION", "deploy a branch to a heroku destination"

  def deploy(branch, dest)
    puts "Attempting to put #{branch} on #{dest}"

    current = `git rev-parse --abbrev-ref HEAD`.chomp

    if current != branch
      puts "Not on the branch #{branch}.  Switch away from #{current}"
      exit
    end

    if branch != "master"
      puts "Generating docs"
      `bin/docapi`
    end

    if !(`git remote | sort | uniq`.match(dest))
      puts "Don't see #{dest} in the list of remotes."
      exit
    end

    puts "Ensuring we are up to date."
    `git pull origin #{branch}`

    puts "Make a bundle"
    `bundle`

    puts "Filling it with a fart from DHH."
    `git push #{dest} #{branch}:master`

    puts "Running Migrations"
    Open3.popen2(*%w[heroku run rails db:migrate -r], dest) do |input, output, _|
      input.close
      output.each { |line| puts line }
    end
  end
end

Deploy.start
