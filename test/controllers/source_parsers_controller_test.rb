require 'test_helper'

class SourceParsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @source_parser = source_parsers(:one)
  end

  test "should get index" do
    get v1_source_parsers_url, as: :json
    assert_response :success
  end

  test "should create source_parser" do
    assert_difference('SourceParser.count') do
      post v1_source_parsers_url, params: { source_parser: { parser_name: @source_parser.parser_name, url_pattern: @source_parser.url_pattern } }, as: :json
    end
  end

  test "should show source_parser" do
    get v1_source_parser_url(@source_parser), as: :json
    assert_response :success
  end

  test "should update source_parser" do
    patch v1_source_parser_url(@source_parser), params: { source_parser: { parser_name: @source_parser.parser_name, url_pattern: @source_parser.url_pattern } }, as: :json
    assert_response 200
  end

  test "should destroy source_parser" do
    assert_difference('SourceParser.count', -1) do
      delete v1_source_parser_url(@source_parser), as: :json
    end
  end
end
