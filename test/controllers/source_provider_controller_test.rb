require 'test_helper'

class SourceProviderControllerTest < ActionDispatch::IntegrationTest
  test "should get version" do
    get source_provider_version_url
    assert_response :success
  end

  test "should get source_providers" do
    get source_provider_source_providers_url
    assert_response :success
  end

end
