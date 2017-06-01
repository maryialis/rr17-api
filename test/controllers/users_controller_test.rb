require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get version" do
    get users_version_url
    assert_response :success
  end

  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

end
