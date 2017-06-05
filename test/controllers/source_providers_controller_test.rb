require 'test_helper'

class SourceProvidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @source_provider = source_providers(:one)
  end

  test "should get index" do
    get v1_source_providers_url, as: :json
    assert_response :success
  end

  test "should create source_provider" do
    assert_difference('SourceProvider.count') do
      post v1_source_providers_url, params: { source_provider: { name: 'SP3', url: 'url3', address: 'address3' } }, as: :json
    end
  end

  test "should show source_provider" do
    get v1_source_provider_url(@source_provider), as: :json
    assert_response :success
  end

  test "should update source_provider" do
    patch v1_source_provider_url(@source_provider), params: { source_provider: { name: @source_provider.name, url: @source_provider.url, address: @source_provider.address } }, as: :json
    assert_response 200
  end

  test "should destroy source_provider" do
    assert_difference('SourceProvider.count', -1) do
      delete v1_source_provider_url(@source_provider), as: :json
    end
  end
  
  test "should parse valid source provider" do
    get v1_url(@source_provider)
    assert_response 200
  end
  
  test "should schedule parsing of all source providers" do
    get v1_source_providers_parse_all_url
    assert_response 203
  end

end
