require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "should get authenticate" do
    post v1_login_url, params: {"auth":{"email":"maryia_lisichonak@epam.com", "password": "123456"}}, as: :json
    assert_response :success
  end

end
