# frozen_string_literal: true

require 'test_helper'

class SeaTableControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get sea_table_index_url
    assert_response :success
  end
end
