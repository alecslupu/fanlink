#!/usr/bin/env ruby

require "slack-ruby-client"

token = ENV["SLACK_API_TOKEN"]

if token.blank?
  puts "You need to set the SLACK_API_TOKEN env variable"
  exit
end

client = Slack::Web::Client.new(token: token)

begin
  client.auth_test
rescue
  puts "Failed to authorize communication with Slack."
  exit
end

branch = `git rev-parse --abbrev-ref HEAD`

if system("bin/docapi")
  if system("zip -r API-Docs.zip API-Docs")
    client.files_upload(
      channels: "#appstech",
      as_user: true,
      file: Faraday::UploadIO.new("FanLink-API-Docs.zip", "application/zip"),
      title: "API Docs",
      initial_comment: "From branch: #{branch}"
    )
  else
    puts "problem running zip command..make sure you have zip executable"
    exit
  end
else
  puts "Problem running docapi"
  exit
end

puts "Done with doc upload."
