# frozen_string_literal: true

require 'dotenv/load'
require 'seatable_ruby'
require 'json'

SeatableRuby.config do |c|
  c.api_token = ENV['SEATABLE_API_TOKEN']
end

basic_info = SeatableRuby::BasicInfo.new

puts JSON.pretty_generate(basic_info.basic_info)
