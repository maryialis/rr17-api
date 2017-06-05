require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get v1_users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post v1_users_url, params: { user: { first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456' } }, as: :json
    end
  end

  test "should show user" do
    get v1_user_url(@user), as: :json
    assert_response :success
  end

  test "should update user" do
    patch v1_user_url(@user), params: { user: { first_name: 'test', last_name: 'test', email: 'test@test.com', password: '123456' } }, as: :json
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete v1_user_url(@user), as: :json
    end
  end

end
