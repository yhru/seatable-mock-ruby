# frozen_string_literal: true

require 'seatable_ruby'

Seatable_ruby.config do |c|
  c.api_token = ENV['SEATABLE_API_TOKEN']

  c.account_credentials = {
    username: ENV['SEATABLE_USERNAME'],
    password: ENV['SEATABLE_PASSWORD']
  }
end
