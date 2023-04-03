require "test_helper"

class Public::SchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_schedules_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_schedules_edit_url
    assert_response :success
  end
end
