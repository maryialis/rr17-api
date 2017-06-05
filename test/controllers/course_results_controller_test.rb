require 'test_helper'

class CourseResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get current" do
    get v1_courses_url
    assert_response :success
  end

  test "should get history" do
    get v1_courses_history_url
    assert_response :success
  end

end
