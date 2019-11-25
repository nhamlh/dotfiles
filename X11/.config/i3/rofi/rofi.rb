#!/usr/bin/env ruby
# frozen_string_literal: true

Dir.chdir(File.dirname(__FILE__))

require 'bundler'

Bundler.require

require 'octokit'
require 'lightly'

def show_help
  puts <<~EOS
    Usage: rofi.rb <action>"

    Valid actions:
    - github
  EOS

  exit 1
end

def run_rofi(items)
  item = `echo -e "#{items.join("\n")}" | rofi -i -dmenu`
  yield item unless item.empty?
end

def get_github_repos
  # Get repos list from github, then generate circleci URL

  token = ENV['ROFI_GITHUB_TOKEN']

  client = Octokit::Client.new(access_token: token, auto_paginate: true)

  cache = Lightly.new life: '168h'

  repos = cache.get 'github_repos' do
    client.repositories
  end

  repos.map(&:full_name)
end

########################
##### Main routine #####
########################
show_help if ARGV.length != 1

case ARGV[0]
when 'github'
  run_rofi(get_github_repos) do |item|
    `firefox --new-tab https://github.com/#{item}`
  end
when 'circleci'
  run_rofi(get_github_repos) do |item|
    `firefox --new-tab https://circleci.com/gh/#{item}`
  end
when 'hostname'
  run_rofi(get_eh_hostname) do |item|
    `firefox --new-tab #{item}`
  end
else
  show_help
end
