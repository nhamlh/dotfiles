#!/usr/bin/env ruby

if ARGV.length != 1
  show_help
end

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
if ARGV[0] == 'github'
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
else
  show_help
end

