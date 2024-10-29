# frozen_string_literal: true

require 'seatable_ruby'

SeatableRuby.config do |c|
  c.api_token = ENV['SEATABLE_API_TOKEN']
end
