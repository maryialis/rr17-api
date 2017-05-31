require 'test_helper'

class SourceParsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get source_parsers_index_url
    assert_response :success
  end

  test "should get show" do
    get source_parsers_show_url
    assert_response :success
  end

  test "should get create" do
    get source_parsers_create_url
    assert_response :success
  end

  test "should get delete" do
    get source_parsers_delete_url
    assert_response :success
  end

  test "should get update" do
    get source_parsers_update_url
    assert_response :success
  end

end
