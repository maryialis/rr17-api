require 'test_helper'

class SourceParsersControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get source_parsers_controller_index_url
    assert_response :success
  end

  test "should get show" do
    get source_parsers_controller_show_url
    assert_response :success
  end

  test "should get create" do
    get source_parsers_controller_create_url
    assert_response :success
  end

  test "should get delete" do
    get source_parsers_controller_delete_url
    assert_response :success
  end

  test "should get update" do
    get source_parsers_controller_update_url
    assert_response :success
  end

end
