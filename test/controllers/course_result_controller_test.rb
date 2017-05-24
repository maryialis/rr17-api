require 'test_helper'

class CourseResultControllerTest < ActionDispatch::IntegrationTest
  test "should get current" do
    get course_result_current_url
    assert_response :success
  end

  test "should get history" do
    get course_result_history_url
    assert_response :success
  end

end
