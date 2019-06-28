#!/usr/bin/env ruby

def show_help
  puts <<-EOS
Usage: rofi.rb <action>"

Valid actions:
- github
  EOS

  exit 1
end

def run_rofi(items)
  item = `echo -e "#{items.map(&:full_name).join("\n")}" | rofi -dmenu`
  yield item unless item.empty?
end

########################
##### Main routine #####
########################
show_help if ARGV.length != 1

case ARGV[0]
when 'github'
  require 'octokit'
  require 'lightly'

  TOKEN = ENV['ROFI_GITHUB_TOKEN']

  client = Octokit::Client.new(access_token: TOKEN, auto_paginate: true)

  cache = Lightly.new life: '168h'

  repos = cache.get 'github_repos' do
    client.repositories
  end

  run_rofi(repos) do |item|
    `firefox --new-tab https://github.com/#{item}`
  end
when 'circleci'
  # Get repos list from github, then generate circleci URL
  require 'octokit'
  require 'lightly'

  TOKEN = ENV['ROFI_GITHUB_TOKEN']

  client = Octokit::Client.new(access_token: TOKEN, auto_paginate: true)

  cache = Lightly.new life: '168h'

  repos = cache.get 'github_repos' do
    client.repositories
  end

  run_rofi(repos) do |item|
    `firefox --new-tab https://circleci.com/gh/#{item}`
  end
else
  show_help
end
