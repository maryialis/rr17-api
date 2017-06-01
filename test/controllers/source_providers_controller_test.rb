require 'test_helper'

class SourceProvidersControllerTest < ActionDispatch::IntegrationTest
  test "should get version" do
    get source_providers_version_url
    assert_response :success
  end

  test "should get source_providers" do
    get source_providers_source_providers_url
    assert_response :success
  end

end
