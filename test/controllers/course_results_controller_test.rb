require 'test_helper'

class CourseResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get current" do
    get course_results_current_url
    assert_response :success
  end

  test "should get history" do
    get course_results_history_url
    assert_response :success
  end

end
