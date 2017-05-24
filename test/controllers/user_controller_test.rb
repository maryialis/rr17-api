require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get version" do
    get user_version_url
    assert_response :success
  end

  test "should get index" do
    get user_index_url
    assert_response :success
  end

  test "should get show" do
    get user_show_url
    assert_response :success
  end

end
