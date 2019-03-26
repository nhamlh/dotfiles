#!/usr/bin/env ruby

require 'octokit'
require 'lightly'

TOKEN = 'xxx'.freeze

client = Octokit::Client.new(access_token: TOKEN, auto_paginate: true)

cache = Lightly.new life: '168h'

repos = cache.get 'github_repos' do
  client.repositories
end

chosen_repo = `echo -e "#{repos.map(&:full_name).join("\n")}" | rofi -dmenu`

`firefox --new-tab https://github.com/#{chosen_repo}`
